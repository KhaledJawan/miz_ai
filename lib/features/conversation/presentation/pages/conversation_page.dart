import 'dart:async';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_glass.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../location/presentation/providers/city_controller.dart';
import '../../domain/conversation_models.dart';
import '../providers/conversation_controller.dart';

class ConversationPage extends ConsumerStatefulWidget {
  const ConversationPage({required this.initialPrompt, super.key});

  final String initialPrompt;

  @override
  ConsumerState<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends ConsumerState<ConversationPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();
  bool _canSend = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send(ConversationController notifier) {
    final value = _controller.text;
    if (value.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    _focusNode.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
    unawaited(SystemChannels.textInput.invokeMethod<void>('TextInput.hide'));
    _controller.clear();
    setState(() => _canSend = false);
    unawaited(notifier.send(value));
    _scrollToLatest();
  }

  void _scrollToLatest() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : AppMotion.standard,
        curve: AppMotion.enter,
      );
    });
  }

  Future<void> _openHistory(ConversationController notifier) async {
    _focusNode.unfocus();
    await notifier.archiveCurrent();
    if (mounted) await context.push(AppRoutes.chatHistory);
  }

  Future<void> _startNewChat(ConversationController notifier) async {
    _focusNode.unfocus();
    await notifier.archiveAndStartNewSearch();
    _controller.clear();
    if (mounted) setState(() => _canSend = false);
  }

  Future<void> _pickLocation(ConversationController notifier) async {
    await context.push(AppRoutes.city);
    if (!mounted) return;
    final selected = ref.read(cityControllerProvider).valueOrNull?.selectedCity;
    if (selected != null) {
      await notifier.retryAfterLocationSelected();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final provider = conversationControllerProvider(widget.initialPrompt);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final inset = MediaQuery.viewInsetsOf(context).bottom;

    ref.listen(provider, (previous, next) {
      if (previous?.messages.length != next.messages.length ||
          previous?.status != next.status) {
        _scrollToLatest();
      }
    });

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) unawaited(notifier.archiveCurrent());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const MizAnimatedFoodBackground(calm: true),
            AnimatedPadding(
              duration: MediaQuery.disableAnimationsOf(context)
                  ? Duration.zero
                  : AppMotion.standard,
              curve: AppMotion.enter,
              padding: EdgeInsets.only(bottom: inset),
              child: SafeArea(
                child: Column(
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
                          MizGlassCircleButton(
                            icon: Icons.history_rounded,
                            semanticLabel: l10n.chatHistory,
                            onPressed:
                                state.status == ConversationStatus.loading
                                ? null
                                : () => unawaited(_openHistory(notifier)),
                            size: 48,
                            prominent: true,
                          ),
                          const Spacer(),
                          MizGlassCircleButton(
                            icon: Icons.add_comment_rounded,
                            semanticLabel: l10n.newChat,
                            onPressed:
                                state.status == ConversationStatus.loading
                                ? null
                                : () => unawaited(_startNewChat(notifier)),
                            size: 48,
                            prominent: true,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state.messages.isEmpty
                          ? Center(
                              child: Text(
                                l10n.promptWhatToday,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              reverse: false,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                AppSpacing.lgPlus,
                                AppSpacing.md,
                                AppSpacing.lgPlus,
                                AppSpacing.xl,
                              ),
                              itemCount: state.messages.length + 1,
                              itemBuilder: (context, index) {
                                if (index < state.messages.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppSpacing.md,
                                    ),
                                    child: _MessageObject(
                                      message: state.messages[index],
                                    ),
                                  );
                                }
                                return _ConversationStatusObject(
                                  state: state,
                                  onRetry: notifier.retry,
                                  onPickLocation: () => _pickLocation(notifier),
                                );
                              },
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppSpacing.lgPlus,
                        AppSpacing.sm,
                        AppSpacing.lgPlus,
                        AppSpacing.md,
                      ),
                      child: MizGlassInput(
                        controller: _controller,
                        focusNode: _focusNode,
                        semanticLabel: l10n.conversationInputLabel,
                        sendLabel: l10n.send,
                        prominent: true,
                        onChanged: (value) =>
                            setState(() => _canSend = value.trim().isNotEmpty),
                        onSend:
                            _canSend &&
                                state.status != ConversationStatus.loading
                            ? () => _send(notifier)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageObject extends StatelessWidget {
  const _MessageObject({required this.message});

  final ConversationMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.author == ConversationAuthor.user;
    return Column(
      crossAxisAlignment: isUser
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        if (message.text.isNotEmpty)
          Align(
            alignment: isUser
                ? AlignmentDirectional.centerEnd
                : AlignmentDirectional.centerStart,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 540),
              child: isUser
                  ? _UserMessageBubble(text: message.text)
                  : _MizMessageBubble(text: message.text),
            ),
          ),
        if (message.places.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          _PlaceResultsList(places: message.places),
        ],
      ],
    );
  }
}

class _UserMessageBubble extends StatelessWidget {
  const _UserMessageBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: const ValueKey('conversation-user-message'),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 18,
            spreadRadius: -6,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class _MizMessageBubble extends StatelessWidget {
  const _MizMessageBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.mizColors;
    return Row(
      key: const ValueKey('conversation-miz-message'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: colors.accent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 12,
                spreadRadius: -5,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.auto_awesome_rounded,
            size: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: MizGlassSurface(
            level: MizGlassLevel.primary,
            prominent: true,
            borderRadius: AppRadii.lg,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaceResultsList extends StatelessWidget {
  const _PlaceResultsList({required this.places});

  final List<AiPlace> places;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 540),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final place in places) ...[
            _PlaceResultCard(place: place),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _PlaceResultCard extends StatelessWidget {
  const _PlaceResultCard({required this.place});

  final AiPlace place;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MizGlassSurface(
      level: MizGlassLevel.primary,
      prominent: true,
      borderRadius: AppRadii.lg,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.black),
          ),
          if (place.address.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              place.address,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.black54),
            ),
          ],
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              if (place.rating != null)
                _PlaceFact(
                  icon: Icons.star_rounded,
                  label: place.rating!.toStringAsFixed(1),
                ),
              if (place.openNow != null)
                _PlaceFact(
                  icon: Icons.schedule_rounded,
                  label: place.openNow! ? l10n.openNow : '',
                ),
              if (place.distanceMeters != null)
                _PlaceFact(
                  icon: Icons.place_rounded,
                  label: place.distanceMeters! >= 1000
                      ? l10n.distanceKilometers(
                          (place.distanceMeters! / 1000).toStringAsFixed(1),
                        )
                      : l10n.distanceMeters(place.distanceMeters!),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlaceFact extends StatelessWidget {
  const _PlaceFact({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.black54),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}

class _ConversationStatusObject extends StatelessWidget {
  const _ConversationStatusObject({
    required this.state,
    required this.onRetry,
    required this.onPickLocation,
  });

  final ConversationState state;
  final VoidCallback onRetry;
  final VoidCallback onPickLocation;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (state.requiresLocation) {
      return MizResultCard(
        title: l10n.locationNeededTitle,
        body: l10n.locationNeededBody,
        icon: Icons.location_on_rounded,
        action: TextButton.icon(
          onPressed: onPickLocation,
          icon: const Icon(Icons.location_on_rounded),
          label: Text(l10n.selectCity),
        ),
      );
    }
    return switch (state.status) {
      ConversationStatus.idle => const SizedBox.shrink(),
      ConversationStatus.loading => Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(l10n.mizThinking),
          ],
        ),
      ),
      ConversationStatus.unavailable ||
      ConversationStatus.error ||
      ConversationStatus.timeout ||
      ConversationStatus.rateLimited ||
      ConversationStatus.placesUnavailable ||
      ConversationStatus.noResults => MizResultCard(
        title: switch (state.status) {
          ConversationStatus.timeout => l10n.aiTimeoutTitle,
          ConversationStatus.rateLimited => l10n.aiRateLimitTitle,
          ConversationStatus.placesUnavailable => l10n.placesUnavailableTitle,
          ConversationStatus.noResults => l10n.noPlacesTitle,
          ConversationStatus.error => l10n.aiRequestErrorTitle,
          _ => l10n.aiUnavailableTitle,
        },
        body: _bodyText(l10n, state),
        icon: switch (state.status) {
          ConversationStatus.timeout => Icons.schedule_rounded,
          ConversationStatus.rateLimited => Icons.hourglass_top_rounded,
          ConversationStatus.placesUnavailable => Icons.location_off_rounded,
          ConversationStatus.noResults => Icons.search_off_rounded,
          _ => Icons.cloud_off_rounded,
        },
        action: state.retryAvailable
            ? TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(l10n.retry),
              )
            : null,
      ),
    };
  }

  /// The user-facing copy, with the originating `miz-ai` error code/detail
  /// appended only in debug builds (never release) — see
  /// `ConversationController`'s catch blocks, which are the only place
  /// [ConversationState.debugErrorCode]/[debugErrorDetail] are set.
  String _bodyText(AppLocalizations l10n, ConversationState state) {
    final body = switch (state.status) {
      ConversationStatus.timeout => l10n.aiTimeoutBody,
      ConversationStatus.rateLimited => l10n.aiRateLimitBody,
      ConversationStatus.placesUnavailable => l10n.placesUnavailableBody,
      ConversationStatus.noResults => l10n.noPlacesBody,
      ConversationStatus.error => l10n.aiRequestErrorBody,
      _ => l10n.aiUnavailableBody,
    };
    if (!kDebugMode || state.debugErrorCode == null) return body;
    return '$body\n\n[debug] ${state.debugErrorCode}: ${state.debugErrorDetail}';
  }
}
