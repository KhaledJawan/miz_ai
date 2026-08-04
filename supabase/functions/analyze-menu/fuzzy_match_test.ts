import { assertEquals, assertExists } from "jsr:@std/assert@1";
import { bestFuzzyMatch, similarityRatio } from "./fuzzy_match.ts";

Deno.test("similarityRatio is 1 for identical strings after normalization", () => {
  assertEquals(similarityRatio("Currywurst", "currywurst"), 1);
  assertEquals(similarityRatio("Käsespätzle", "kasespatzle"), 1);
});

Deno.test("similarityRatio ignores punctuation and extra whitespace", () => {
  assertEquals(similarityRatio("  Currywurst!! ", "currywurst"), 1);
});

Deno.test("similarityRatio is 0 for one empty string", () => {
  assertEquals(similarityRatio("", "sauerbraten"), 0);
  assertEquals(similarityRatio("sauerbraten", ""), 0);
});

Deno.test("similarityRatio is between 0 and 1 for partial matches", () => {
  const ratio = similarityRatio("Sauerbraten", "Sauerkraut");
  if (ratio <= 0 || ratio >= 1) throw new Error(`expected 0 < ratio < 1, got ${ratio}`);
});

Deno.test("bestFuzzyMatch picks the highest combined-confidence candidate", () => {
  const result = bestFuzzyMatch("Sauerbraten", [
    { id: "1", name: "Sauerkraut", remoteScore: 0.5 },
    { id: "2", name: "Sauerbraten", remoteScore: 0.9 },
  ]);
  assertExists(result);
  assertEquals(result.candidate.id, "2");
});

Deno.test("bestFuzzyMatch returns null when no candidate clears the confidence bar", () => {
  const result = bestFuzzyMatch("Sauerbraten", [
    { id: "1", name: "Completely Different Dish", remoteScore: 0.1 },
  ]);
  assertEquals(result, null);
});

Deno.test("bestFuzzyMatch returns null for an empty candidate list", () => {
  assertEquals(bestFuzzyMatch("Sauerbraten", []), null);
});

Deno.test("bestFuzzyMatch clamps an out-of-range remote score instead of trusting it", () => {
  const result = bestFuzzyMatch("Sauerbraten", [
    { id: "1", name: "Sauerbraten", remoteScore: 50 }, // clearly not a 0-1 score
  ]);
  assertExists(result);
  // Even with a huge remote score, the combined confidence must stay <= 1
  // (0.4 weight * 1.0 clamp + 0.6 weight * localSimilarity <= 1).
  if (result.combinedConfidence > 1) throw new Error("remote score was not clamped");
});
