/// Payload for `AppRoutes.chat`'s `extra` when the caller needs to attach
/// more than a plain prompt string — currently just the Menu Assistant's
/// Stage 4 hand-off (see `MenuAnalysisResults`'s "Ask Miz about this menu"
/// action). Lives in `core/router/` rather than a feature's `domain/` so
/// both `camera/` and `conversation/` can depend on it without one feature
/// reaching into another's internals (CLAUDE.md §3).
class ChatLaunchArgs {
  const ChatLaunchArgs({required this.prompt, this.menuContext});

  final String prompt;

  /// A compact, deterministic summary of a just-scanned menu (matched
  /// dishes, categories, safety status) — see
  /// `buildMenuContextSummary` in the camera feature. When non-null, every
  /// message in the resulting chat is treated server-side as a lightweight
  /// Stage 4 follow-up (see `supabase/functions/miz-ai/system_instruction.ts`
  /// `buildMenuFollowUpSystemInstruction`), never a fresh general search.
  final String? menuContext;
}
