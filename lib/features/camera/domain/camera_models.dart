enum CameraMode { foodRecognition, mizQr, menuScan }

enum CaptureSource { camera, gallery }

class FoodRecognitionCandidate {
  const FoodRecognitionCandidate({
    required this.name,
    required this.confidence,
    this.description = '',
  });

  final String name;
  final double confidence;
  final String description;

  factory FoodRecognitionCandidate.fromJson(Map<String, dynamic> json) =>
      FoodRecognitionCandidate(
        name: json['name'] as String? ?? '',
        confidence: ((json['confidence'] as num?)?.toDouble() ?? 0).clamp(0, 1),
        description: json['description'] as String? ?? '',
      );
}

class FoodRecognitionResult {
  const FoodRecognitionResult({
    required this.recognized,
    required this.overview,
    required this.candidates,
  });

  final bool recognized;
  final String overview;
  final List<FoodRecognitionCandidate> candidates;

  factory FoodRecognitionResult.fromJson(Map<String, dynamic> json) =>
      FoodRecognitionResult(
        recognized: json['recognized'] as bool? ?? false,
        overview: json['overview'] as String? ?? '',
        candidates: (json['candidates'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map(
              (candidate) => FoodRecognitionCandidate.fromJson(
                Map<String, dynamic>.from(candidate),
              ),
            )
            .where((candidate) => candidate.name.isNotEmpty)
            .toList(growable: false),
      );
}

enum CameraStage {
  permission,
  live,
  preview,
  processing,
  multipleMatches,
  uncertain,
  result,
  denied,
  unavailable,
  offline,
  error,
  invalidQr,
  expiredQr,
  unpublishedQr,
  inactiveQr,
}

class TemporaryCapture {
  const TemporaryCapture({
    required this.id,
    required this.path,
    required this.createdAt,
    this.source = CaptureSource.camera,
    this.mimeType,
  });

  final String id;
  final String path;
  final DateTime createdAt;
  final CaptureSource source;
  final String? mimeType;
}

enum MenuItemConfidence { high, medium, low }

class MenuItemExplanation {
  const MenuItemExplanation({
    required this.name,
    required this.explanation,
    required this.price,
    required this.dietaryTags,
    required this.possibleAllergens,
    required this.confidence,
  });

  final String name;
  final String explanation;
  final String? price;
  final List<String> dietaryTags;
  final List<String> possibleAllergens;
  final MenuItemConfidence confidence;

  factory MenuItemExplanation.fromJson(Map<String, dynamic> json) =>
      MenuItemExplanation(
        name: json['name'] as String? ?? '',
        explanation: json['explanation'] as String? ?? '',
        price: json['price'] as String?,
        dietaryTags: (json['dietaryTags'] as List<dynamic>? ?? const [])
            .whereType<String>()
            .toList(growable: false),
        possibleAllergens:
            (json['possibleAllergens'] as List<dynamic>? ?? const [])
                .whereType<String>()
                .toList(growable: false),
        confidence: MenuItemConfidence.values.firstWhere(
          (value) => value.name == json['confidence'],
          orElse: () => MenuItemConfidence.low,
        ),
      );
}

class MenuSectionExplanation {
  const MenuSectionExplanation({required this.title, required this.items});

  final String title;
  final List<MenuItemExplanation> items;

  factory MenuSectionExplanation.fromJson(Map<String, dynamic> json) =>
      MenuSectionExplanation(
        title: json['title'] as String? ?? '',
        items: (json['items'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map(
              (item) =>
                  MenuItemExplanation.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList(growable: false),
      );
}

class MenuAnalysisResult {
  const MenuAnalysisResult({
    required this.readable,
    required this.overview,
    required this.sections,
    required this.notes,
    this.detectedLanguage,
    this.currency,
  });

  final bool readable;
  final String overview;
  final String? detectedLanguage;
  final String? currency;
  final List<MenuSectionExplanation> sections;
  final List<String> notes;

  int get itemCount =>
      sections.fold(0, (count, section) => count + section.items.length);

  factory MenuAnalysisResult.fromJson(Map<String, dynamic> json) =>
      MenuAnalysisResult(
        readable: json['readable'] as bool? ?? false,
        overview: json['overview'] as String? ?? '',
        detectedLanguage: json['detectedLanguage'] as String?,
        currency: json['currency'] as String?,
        sections: (json['sections'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map(
              (section) => MenuSectionExplanation.fromJson(
                Map<String, dynamic>.from(section),
              ),
            )
            .toList(growable: false),
        notes: (json['notes'] as List<dynamic>? ?? const [])
            .whereType<String>()
            .toList(growable: false),
      );
}

class CameraWorkflowState {
  const CameraWorkflowState({
    this.mode = CameraMode.menuScan,
    this.stage = CameraStage.permission,
    this.captures = const [],
    this.activeCaptureIndex,
    this.menuAnalysis,
    this.foodCandidates = const [],
    this.foodOverview,
    this.errorCode,
  });

  final CameraMode mode;
  final CameraStage stage;
  final List<TemporaryCapture> captures;
  final int? activeCaptureIndex;
  final MenuAnalysisResult? menuAnalysis;
  final List<FoodRecognitionCandidate> foodCandidates;
  final String? foodOverview;
  final String? errorCode;

  CameraWorkflowState copyWith({
    CameraMode? mode,
    CameraStage? stage,
    List<TemporaryCapture>? captures,
    int? activeCaptureIndex,
    bool clearActiveCapture = false,
    MenuAnalysisResult? menuAnalysis,
    bool clearMenuAnalysis = false,
    List<FoodRecognitionCandidate>? foodCandidates,
    String? foodOverview,
    bool clearFoodAnalysis = false,
    String? errorCode,
  }) => CameraWorkflowState(
    mode: mode ?? this.mode,
    stage: stage ?? this.stage,
    captures: captures ?? this.captures,
    activeCaptureIndex: clearActiveCapture
        ? null
        : activeCaptureIndex ?? this.activeCaptureIndex,
    menuAnalysis: clearMenuAnalysis ? null : menuAnalysis ?? this.menuAnalysis,
    foodCandidates: clearFoodAnalysis
        ? const []
        : foodCandidates ?? this.foodCandidates,
    foodOverview: clearFoodAnalysis ? null : foodOverview ?? this.foodOverview,
    errorCode: errorCode,
  );
}
