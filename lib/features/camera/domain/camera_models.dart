/// Which analysis pipeline a captured photo is routed through. There is no
/// longer a user-facing picker for this — it's set automatically from
/// [CaptureKind] once `classify-capture` runs (see
/// `CameraWorkflowController.analyzeCapture`). `null` in
/// [CameraWorkflowState.mode] means no photo has been classified yet.
enum CameraMode { foodRecognition, menuScan }

enum CaptureSource { camera, gallery }

/// What a single captured still photo was classified as by the
/// `classify-capture` Edge Function — QR codes are decoded live, on-device,
/// and never go through this classification at all.
enum CaptureKind { menu, singleDish, unrecognized }

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

/// Whether a matched dish fits the user's Food Profile — computed
/// server-side, deterministically, from Mizzz's trusted catalog fields
/// (see `supabase/functions/analyze-menu/safety_classifier.ts`). Never
/// inferred by the client, and never null for a dish that has a catalog
/// match (an unmatched dish has a null [MatchedDish.safetyStatus] instead).
enum DishSafetyStatus { safe, warning, restricted }

DishSafetyStatus? _dishSafetyStatusFromJson(dynamic value) =>
    switch (value) {
      'safe' => DishSafetyStatus.safe,
      'warning' => DishSafetyStatus.warning,
      'restricted' => DishSafetyStatus.restricted,
      _ => null,
    };

/// A 3-tier traffic-light signal relative to the median price of other
/// matched dishes in the same category on this same scan — never a claim
/// about objective fair pricing. Rendered as a colored $ mark: green for
/// `good`, amber for `high`, red for `veryHigh`; `unknown` renders plain.
enum PriceIndicator { good, high, veryHigh, unknown }

PriceIndicator _priceIndicatorFromJson(dynamic value) => switch (value) {
  'good' => PriceIndicator.good,
  'high' => PriceIndicator.high,
  'very_high' => PriceIndicator.veryHigh,
  _ => PriceIndicator.unknown,
};

/// A stable reason code the UI localizes — never a free-text sentence from
/// the backend. See `DishSafetyReason` in `safety_classifier.ts`.
class DishSafetyReason {
  const DishSafetyReason({required this.code, this.detail});

  final String code;
  final String? detail;

  factory DishSafetyReason.fromJson(Map<String, dynamic> json) =>
      DishSafetyReason(
        code: json['code'] as String? ?? '',
        detail: json['detail'] as String?,
      );
}

/// One dish as extracted from the photo (Stage 1) and, when a confident
/// catalog match was found, enriched + classified (Stage 2/3). A null
/// [matchedFoodId] means no Mizzz catalog entry cleared the confidence
/// threshold — the UI must render a plain fallback, never a fabricated
/// match or safety claim.
class MatchedDish {
  const MatchedDish({
    required this.extractedName,
    required this.price,
    required this.priceIndicator,
    required this.matchedFoodId,
    required this.matchedName,
    required this.shortDescription,
    required this.imagePath,
    required this.matchConfidence,
    required this.safetyStatus,
    required this.safetyReasons,
    required this.safetyCertain,
  });

  final String extractedName;
  final double? price;
  final PriceIndicator priceIndicator;
  final String? matchedFoodId;
  final String? matchedName;
  final String? shortDescription;

  /// A Mizzz Storage path in a private bucket — not yet resolvable to a
  /// renderable URL from Miz AI (see docs/EDGE_FUNCTIONS.md), so the UI
  /// must not attempt to load it as an image today.
  final String? imagePath;
  final double? matchConfidence;
  final DishSafetyStatus? safetyStatus;
  final List<DishSafetyReason> safetyReasons;
  final bool safetyCertain;

  bool get isMatched => matchedFoodId != null;

  factory MatchedDish.fromJson(Map<String, dynamic> json) => MatchedDish(
    extractedName: json['extractedName'] as String? ?? '',
    price: (json['price'] as num?)?.toDouble(),
    priceIndicator: _priceIndicatorFromJson(json['priceIndicator']),
    matchedFoodId: json['matchedFoodId'] as String?,
    matchedName: json['matchedName'] as String?,
    shortDescription: json['shortDescription'] as String?,
    imagePath: json['imagePath'] as String?,
    matchConfidence: (json['matchConfidence'] as num?)?.toDouble(),
    safetyStatus: _dishSafetyStatusFromJson(json['safetyStatus']),
    safetyReasons: (json['safetyReasons'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((reason) => DishSafetyReason.fromJson(Map<String, dynamic>.from(reason)))
        .toList(growable: false),
    safetyCertain: json['safetyCertain'] as bool? ?? true,
  );
}

class MenuAnalysisCategory {
  const MenuAnalysisCategory({required this.name, required this.dishes});

  final String name;
  final List<MatchedDish> dishes;

  factory MenuAnalysisCategory.fromJson(Map<String, dynamic> json) =>
      MenuAnalysisCategory(
        name: json['name'] as String? ?? '',
        dishes: (json['dishes'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((dish) => MatchedDish.fromJson(Map<String, dynamic>.from(dish)))
            .toList(growable: false),
      );
}

class MenuAnalysisResult {
  const MenuAnalysisResult({
    required this.readable,
    required this.categories,
    required this.notes,
    this.detectedLanguage,
    this.currency,
  });

  final bool readable;
  final String? detectedLanguage;
  final String? currency;
  final List<MenuAnalysisCategory> categories;
  final List<String> notes;

  int get dishCount =>
      categories.fold(0, (count, category) => count + category.dishes.length);

  factory MenuAnalysisResult.fromJson(Map<String, dynamic> json) =>
      MenuAnalysisResult(
        readable: json['readable'] as bool? ?? false,
        detectedLanguage: json['detectedLanguage'] as String?,
        currency: json['currency'] as String?,
        categories: (json['categories'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map(
              (category) => MenuAnalysisCategory.fromJson(
                Map<String, dynamic>.from(category),
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
    this.mode,
    this.stage = CameraStage.permission,
    this.captures = const [],
    this.activeCaptureIndex,
    this.menuAnalysis,
    this.foodCandidates = const [],
    this.foodOverview,
    this.errorCode,
  });

  /// Null until a captured photo has been classified — see [CameraMode].
  final CameraMode? mode;
  final CameraStage stage;
  final List<TemporaryCapture> captures;
  final int? activeCaptureIndex;
  final MenuAnalysisResult? menuAnalysis;
  final List<FoodRecognitionCandidate> foodCandidates;
  final String? foodOverview;
  final String? errorCode;

  CameraWorkflowState copyWith({
    CameraMode? mode,
    bool clearMode = false,
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
    mode: clearMode ? null : mode ?? this.mode,
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
