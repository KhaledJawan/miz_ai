import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant.freezed.dart';

/// Core restaurant entity. Fields mirror the approved prototype's
/// `RESTAURANTS` mock array (see docs/DATABASE.md `restaurants` table for
/// the eventual Supabase shape) so mock data ports 1:1 when this becomes
/// live in M6.
@freezed
abstract class Restaurant with _$Restaurant {
  const factory Restaurant({
    required String id,
    required String name,
    required String cuisine,
    required String tag,
    required int priceTier, // 0 = no limit/no data, 1..3 = €/€€/€€€
    required double rating,
    required double distanceKm,
    required int etaMinutes,
    required String signatureDish,
    required String recommendationReason,
    required String reviewQuote,
    required String reviewer,
    required String askMizAnswer,
    String? imageAsset,
  }) = _Restaurant;
}
