/// The app has no authentication yet and stores exactly one food profile
/// per device install. Every table still carries a `localUserId` column so
/// multi-account support later is a real migration, not a rewrite — see
/// docs/DECISIONS.md ADR-013.
const int kLocalUserId = 1;
