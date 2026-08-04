/// Backs the unified camera experience: a single still photo capture (QR
/// codes are decoded live, on-device, and never reach this function) is
/// classified before the client decides whether to call `analyze-menu` or
/// `analyze-food` — removing the manual mode picker without duplicating
/// either pipeline's own vision/matching logic.

export type CaptureKind = "menu" | "single_dish" | "unrecognized";

export interface ClassifyCaptureRequest {
  locale: "en" | "de" | "fa";
  image: { mimeType: string; data: string };
}

export interface ClassifyCaptureResult {
  kind: CaptureKind;
}
