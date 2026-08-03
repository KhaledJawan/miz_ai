export interface IncomingMenuImage {
  mimeType?: unknown;
  data?: unknown;
}

export interface MenuAnalysisRequest {
  locale: "en" | "de" | "fa";
  images: Array<{ mimeType: string; data: string }>;
}

export interface MenuItemExplanation {
  name: string;
  explanation: string;
  price: string | null;
  dietaryTags: string[];
  possibleAllergens: string[];
  confidence: "high" | "medium" | "low";
}

export interface MenuSectionExplanation {
  title: string;
  items: MenuItemExplanation[];
}

export interface MenuAnalysis {
  readable: boolean;
  detectedLanguage: string | null;
  overview: string;
  currency: string | null;
  sections: MenuSectionExplanation[];
  notes: string[];
}
