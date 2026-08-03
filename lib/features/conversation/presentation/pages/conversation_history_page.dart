import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/conversation_models.dart';
import '../providers/conversation_history_providers.dart';

class ConversationHistoryPage extends ConsumerWidget {
  const ConversationHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final history = ref.watch(conversationHistoryProvider);
    return Scaffold(
      body: Stack(
        children: [
          const MizAnimatedFoodBackground(calm: true),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lgPlus,
                    AppSpacing.md,
                    AppSpacing.lgPlus,
                    AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      MizFloatingDismissButton(
                        semanticLabel: MaterialLocalizations.of(
                          context,
                        ).backButtonTooltip,
                        icon: Icons.arrow_back_rounded,
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(
                        child: Text(
                          l10n.chatHistory,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: history.when(
                    data: (archives) => archives.isEmpty
                        ? _EmptyHistory()
                        : ListView.separated(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              AppSpacing.lgPlus,
                              AppSpacing.lg,
                              AppSpacing.lgPlus,
                              AppSpacing.xxl,
                            ),
                            itemCount: archives.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: AppSpacing.md),
                            itemBuilder: (context, index) =>
                                _ArchiveCard(archive: archives[index]),
                          ),
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    error: (_, _) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Text(l10n.chatHistoryUnavailable),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: MizGlassSurface(
          prominent: true,
          borderRadius: AppRadii.xl,
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history_rounded,
                size: 34,
                color: context.mizColors.accent,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.noChatHistory,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.noChatHistoryBody,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArchiveCard extends ConsumerWidget {
  const _ArchiveCard({required this.archive});

  final ConversationArchive archive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = archive.messages.reversed
        .map((message) => message.text.trim())
        .firstWhere((text) => text.isNotEmpty, orElse: () => '');
    final localizations = MaterialLocalizations.of(context);
    final date = localizations.formatShortDate(archive.updatedAt);
    final time = localizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(archive.updatedAt),
    );
    return MizGlassSurface(
      prominent: true,
      borderRadius: AppRadii.lg,
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      onTap: () => _showArchive(context, archive),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: context.mizColors.accent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  archive.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.black),
                ),
                if (preview.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                ],
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$date · $time',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Colors.black45),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: context.l10n.deleteChat,
            onPressed: () => unawaited(
              ref
                  .read(conversationHistoryRepositoryProvider)
                  .delete(archive.id),
            ),
            icon: const Icon(Icons.delete_outline_rounded),
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Future<void> _showArchive(BuildContext context, ConversationArchive archive) {
    return MizSpatialSheet.show<void>(
      context: context,
      builder: (context) => MizSpatialSheet(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.76,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      archive.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).closeButtonTooltip,
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: ListView.separated(
                  itemCount: archive.messages.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) =>
                      _ArchivedMessage(message: archive.messages[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArchivedMessage extends StatelessWidget {
  const _ArchivedMessage({required this.message});

  final ConversationMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.author == ConversationAuthor.user;
    final text = message.text.isNotEmpty
        ? message.text
        : context.l10n.restaurantResultsCount(message.places.length);
    return Align(
      alignment: isUser
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 540),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.black : const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
