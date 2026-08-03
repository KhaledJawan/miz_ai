import { assertEquals, assertRejects } from "jsr:@std/assert@1";
import { MizAiError } from "./errors.ts";
import {
  continueInteraction,
  createInteraction,
  finalText,
  functionCallSteps,
  type GeminiInteractionResponse,
} from "./gemini_client.ts";

function stubFetch(
  handler: (input: string | URL | Request, init?: RequestInit) => Response,
): () => void {
  const original = globalThis.fetch;
  globalThis.fetch =
    ((input: string | URL | Request, init?: RequestInit) =>
      Promise.resolve(handler(input, init))) as typeof fetch;
  return () => {
    globalThis.fetch = original;
  };
}

const textOnlyResponse: GeminiInteractionResponse = {
  id: "interaction-1",
  status: "completed",
  steps: [{ type: "model_output", content: [{ type: "text", text: "Sushi is a Japanese dish." }] }],
};

const functionCallResponse: GeminiInteractionResponse = {
  id: "interaction-2",
  status: "completed",
  steps: [
    {
      type: "function_call",
      id: "call-1",
      name: "search_nearby_places",
      arguments: { placeTypes: ["cafe"] },
    },
  ],
};

const reliability = { deadlineMs: Date.now() + 60000, requestId: "test-request" };

Deno.test("createInteraction posts to the Interactions endpoint with the api-key header", async () => {
  let calledUrl = "";
  let calledHeaders: Headers | null = null;
  let calledBody: Record<string, unknown> = {};
  const restore = stubFetch((input, init) => {
    calledUrl = String(input);
    calledHeaders = new Headers(init?.headers);
    calledBody = JSON.parse(String(init?.body));
    return new Response(JSON.stringify(textOnlyResponse), { status: 200 });
  });
  try {
    await createInteraction({
      apiKey: "test-key",
      model: "gemini-3.6-flash",
      input: "hello",
      systemInstruction: "be helpful",
      tools: [],
      ...reliability,
    });
    assertEquals(calledUrl, "https://generativelanguage.googleapis.com/v1beta/interactions");
    assertEquals((calledHeaders as unknown as Headers).get("x-goog-api-key"), "test-key");
    assertEquals(calledBody.model, "gemini-3.6-flash");
    assertEquals(calledBody.input, "hello");
    assertEquals(calledBody.system_instruction, "be helpful");
  } finally {
    restore();
  }
});

Deno.test("continueInteraction sends previous_interaction_id and function_result input", async () => {
  let calledBody: Record<string, unknown> = {};
  const restore = stubFetch((_input, init) => {
    calledBody = JSON.parse(String(init?.body));
    return new Response(JSON.stringify(textOnlyResponse), { status: 200 });
  });
  try {
    await continueInteraction({
      apiKey: "test-key",
      model: "gemini-3.6-flash",
      previousInteractionId: "interaction-2",
      functionResults: [
        {
          type: "function_result",
          name: "search_nearby_places",
          call_id: "call-1",
          result: [{ type: "text", text: "{}" }],
        },
      ],
      tools: [],
      ...reliability,
    });
    assertEquals(calledBody.previous_interaction_id, "interaction-2");
    assertEquals(Array.isArray(calledBody.input), true);
  } finally {
    restore();
  }
});

Deno.test("gemini_client maps 429 to AI_RATE_LIMIT", async () => {
  const restore = stubFetch(() => new Response("rate limited", { status: 429 }));
  try {
    const error = await assertRejects(
      () =>
        createInteraction({
          apiKey: "test-key",
          model: "gemini-3.6-flash",
          input: "hi",
          systemInstruction: "",
          tools: [],
          ...reliability,
        }),
      MizAiError,
    );
    assertEquals((error as MizAiError).code, "AI_RATE_LIMIT");
  } finally {
    restore();
  }
});

Deno.test("gemini_client maps 401/403 to AI_CONFIGURATION_ERROR", async () => {
  const restore = stubFetch(() => new Response("forbidden", { status: 403 }));
  try {
    const error = await assertRejects(
      () =>
        createInteraction({
          apiKey: "bad-key",
          model: "gemini-3.6-flash",
          input: "hi",
          systemInstruction: "",
          tools: [],
          ...reliability,
        }),
      MizAiError,
    );
    assertEquals((error as MizAiError).code, "AI_CONFIGURATION_ERROR");
  } finally {
    restore();
  }
});

Deno.test("functionCallSteps extracts only function_call steps", () => {
  assertEquals(functionCallSteps(textOnlyResponse).length, 0);
  assertEquals(functionCallSteps(functionCallResponse).length, 1);
  assertEquals(functionCallSteps(functionCallResponse)[0].name, "search_nearby_places");
});

Deno.test("finalText joins model_output text blocks and returns null when absent", () => {
  assertEquals(finalText(textOnlyResponse), "Sushi is a Japanese dish.");
  assertEquals(finalText(functionCallResponse), null);
});

Deno.test("gemini_client retries one temporary 5xx then succeeds", async () => {
  let attempts = 0;
  const restore = stubFetch(() => {
    attempts++;
    return attempts === 1
      ? new Response("temporary", { status: 503 })
      : new Response(JSON.stringify(textOnlyResponse), { status: 200 });
  });
  try {
    const result = await createInteraction({
      apiKey: "test-key",
      model: "gemini-3.6-flash",
      input: "full history",
      retryInput: "short input",
      systemInstruction: "system",
      tools: [],
      deadlineMs: Date.now() + 1000,
      requestId: "retry-test",
    });
    assertEquals(result.id, "interaction-1");
    assertEquals(attempts, 2);
  } finally {
    restore();
  }
});

Deno.test("gemini_client retries one timeout then returns AI_TIMEOUT", async () => {
  let attempts = 0;
  const original = globalThis.fetch;
  globalThis.fetch = ((_input: string | URL | Request, init?: RequestInit) => {
    attempts++;
    return new Promise<Response>((_resolve, reject) => {
      init?.signal?.addEventListener(
        "abort",
        () => reject(new DOMException("aborted", "AbortError")),
      );
    });
  }) as typeof fetch;
  try {
    const error = await assertRejects(
      () =>
        createInteraction({
          apiKey: "test-key",
          model: "gemini-3.6-flash",
          input: "hello",
          systemInstruction: "system",
          tools: [],
          deadlineMs: Date.now() + 100,
          requestId: "timeout-test",
          attemptTimeoutMs: 5,
        }),
      MizAiError,
    );
    assertEquals((error as MizAiError).code, "AI_TIMEOUT");
    assertEquals(attempts, 2);
  } finally {
    globalThis.fetch = original;
  }
});

Deno.test("gemini_client rejects a malformed success response safely", async () => {
  const restore = stubFetch(() =>
    new Response(JSON.stringify({ unexpected: true }), { status: 200 })
  );
  try {
    const error = await assertRejects(
      () =>
        createInteraction({
          apiKey: "test-key",
          model: "gemini-3.6-flash",
          input: "hello",
          systemInstruction: "system",
          tools: [],
          deadlineMs: Date.now() + 1000,
          requestId: "malformed-test",
        }),
      MizAiError,
    );
    assertEquals((error as MizAiError).code, "AI_UNAVAILABLE");
  } finally {
    restore();
  }
});
