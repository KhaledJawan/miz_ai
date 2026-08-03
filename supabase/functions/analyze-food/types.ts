export interface FoodAnalysisRequest {
  locale: "en" | "de" | "fa";
  image: { mimeType: string; data: string };
}

export interface FoodCandidate {
  name: string;
  description: string;
  confidence: number;
}

export interface FoodAnalysis {
  recognized: boolean;
  overview: string;
  candidates: FoodCandidate[];
}
