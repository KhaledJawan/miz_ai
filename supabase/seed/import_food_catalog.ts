type JsonObject = Record<string, unknown>;

interface SeedDocument {
  sourceName: string;
  sourceVersion?: string;
  sourceUrl?: string | null;
  license: string;
  foods: JsonObject[];
}

function option(name: string): string | undefined {
  const prefix = `--${name}=`;
  return Deno.args.find((value) => value.startsWith(prefix))?.slice(prefix.length);
}

function hasFlag(name: string): boolean {
  return Deno.args.includes(`--${name}`);
}

function fail(message: string): never {
  throw new Error(message);
}

function normalizeFoodName(value: string): string {
  return value
    .toLocaleLowerCase()
    .replaceAll("ـ", " ")
    .replace(/[أإآٱ]/gu, "ا")
    .replace(/ة/gu, "ه")
    .replace(/ى/gu, "ي")
    .replace(/[\p{P}\p{Z}\s]+/gu, " ")
    .trim();
}

function validateSeed(value: unknown): SeedDocument {
  if (typeof value !== "object" || value === null || Array.isArray(value)) {
    return fail("Seed root must be an object.");
  }
  const root = value as JsonObject;
  if (typeof root.sourceName !== "string" || root.sourceName.trim().length < 2) {
    return fail("sourceName is required.");
  }
  if (typeof root.license !== "string" || root.license.trim().length < 2) {
    return fail("license is required.");
  }
  if (!Array.isArray(root.foods) || root.foods.length === 0) {
    return fail("foods must be a non-empty array.");
  }

  const normalizedNames = new Set<string>();
  const slugs = new Set<string>();
  for (const [index, rawFood] of root.foods.entries()) {
    if (typeof rawFood !== "object" || rawFood === null || Array.isArray(rawFood)) {
      return fail(`foods[${index}] must be an object.`);
    }
    const food = rawFood as JsonObject;
    if (typeof food.canonicalName !== "string" || food.canonicalName.trim().length === 0) {
      return fail(`foods[${index}].canonicalName is required.`);
    }
    if (
      typeof food.slug !== "string" ||
      !/^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(food.slug)
    ) {
      return fail(`foods[${index}].slug is invalid.`);
    }
    if (food.aliases !== undefined && !Array.isArray(food.aliases)) {
      return fail(`foods[${index}].aliases must be an array.`);
    }
    if (food.translations !== undefined && !Array.isArray(food.translations)) {
      return fail(`foods[${index}].translations must be an array.`);
    }
    const normalizedName = normalizeFoodName(food.canonicalName);
    if (normalizedNames.has(normalizedName)) {
      return fail(`Duplicate normalized canonical name at foods[${index}].`);
    }
    if (slugs.has(food.slug)) {
      return fail(`Duplicate slug at foods[${index}].`);
    }
    normalizedNames.add(normalizedName);
    slugs.add(food.slug);
  }
  return root as unknown as SeedDocument;
}

async function sha256(value: string): Promise<string> {
  const bytes = new TextEncoder().encode(value);
  const digest = await crypto.subtle.digest("SHA-256", bytes);
  return [...new Uint8Array(digest)]
    .map((byte) => byte.toString(16).padStart(2, "0"))
    .join("");
}

async function callRpc(name: string, body: JsonObject): Promise<unknown> {
  const url = Deno.env.get("SUPABASE_URL");
  const publishableKey = Deno.env.get("SUPABASE_PUBLISHABLE_KEY");
  const accessToken = Deno.env.get("CATALOG_ADMIN_ACCESS_TOKEN");
  if (!url || !publishableKey || !accessToken) {
    return fail(
      "Remote mode requires SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, and " +
        "CATALOG_ADMIN_ACCESS_TOKEN. Never use a service-role key here.",
    );
  }
  const response = await fetch(`${url}/rest/v1/rpc/${name}`, {
    method: "POST",
    headers: {
      apikey: publishableKey,
      authorization: `Bearer ${accessToken}`,
      "content-type": "application/json",
    },
    body: JSON.stringify(body),
  });
  const responseText = await response.text();
  if (!response.ok) {
    return fail(`RPC ${name} failed with HTTP ${response.status}: ${responseText}`);
  }
  return responseText.length === 0 ? null : JSON.parse(responseText);
}

async function main(): Promise<void> {
  const rollbackId = option("rollback");
  if (rollbackId) {
    const reason = option("reason") ?? "Operator-requested staged import rollback";
    const result = await callRpc("rollback_food_catalog_import", {
      p_batch_id: rollbackId,
      p_reason: reason,
    });
    console.log(JSON.stringify(result));
    return;
  }

  const filePath = Deno.args.find((value) => !value.startsWith("--"));
  if (!filePath) {
    return fail("Pass a seed JSON path, or --rollback=BATCH_UUID.");
  }
  const seed = validateSeed(JSON.parse(await Deno.readTextFile(filePath)));
  const batchSize = Math.min(Math.max(Number(option("batch-size") ?? "200"), 1), 500);
  const remote = hasFlag("remote");
  const apply = hasFlag("apply");

  console.log(
    `Validated ${seed.foods.length} foods from ${seed.sourceName}; ` +
      `mode=${remote ? (apply ? "remote-stage" : "remote-dry-run") : "local-only"}.`,
  );
  if (!remote) return;

  for (let offset = 0; offset < seed.foods.length; offset += batchSize) {
    const foods = seed.foods.slice(offset, offset + batchSize);
    const canonicalBatch = JSON.stringify({
      sourceName: seed.sourceName,
      sourceVersion: seed.sourceVersion ?? null,
      offset,
      foods,
    });
    const result = await callRpc("stage_food_catalog_import", {
      p_source_name: seed.sourceName,
      p_source_version: seed.sourceVersion ?? null,
      p_source_url: seed.sourceUrl ?? null,
      p_license: seed.license,
      p_content_hash: await sha256(canonicalBatch),
      p_records: foods,
      p_dry_run: !apply,
    });
    console.log(JSON.stringify(result));
  }
}

if (import.meta.main) {
  await main();
}
