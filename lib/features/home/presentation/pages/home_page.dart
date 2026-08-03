import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/localization.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../location/presentation/providers/city_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _inputController = TextEditingController();
  final _focusNode = FocusNode();
  bool _canSend = false;

  @override
  void dispose() {
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    final next = value.trim().isNotEmpty;
    if (next != _canSend) setState(() => _canSend = next);
  }

  void _submit() {
    final message = _inputController.text.trim();
    if (message.isEmpty) return;
    _focusNode.unfocus();
    context.push(AppRoutes.chat, extra: message);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final city = ref.watch(cityControllerProvider).valueOrNull?.selectedCity;
    final prompts = [
      l10n.promptWhatToday,
      l10n.promptMatchTaste,
      l10n.promptRestaurantsNearby,
      l10n.promptSomethingNew,
      l10n.promptLightMeal,
      l10n.promptNearMeNow,
      l10n.promptSpicy,
      l10n.promptCafe,
    ];
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const MizAnimatedFoodBackground(),
          AnimatedPadding(
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : AppMotion.standard,
            curve: AppMotion.enter,
            padding: EdgeInsets.only(bottom: keyboardInset),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.lgPlus,
                      AppSpacing.md,
                      AppSpacing.lgPlus,
                      0,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 260),
                        child: MizLocationCapsule(
                          key: const ValueKey('home-city-selector'),
                          label: city ?? l10n.noCitySelected,
                          semanticLabel: city == null
                              ? l10n.selectCity
                              : l10n.changeCity(city),
                          isSelected: city != null,
                          prominent: true,
                          onTap: () => context.push(AppRoutes.city),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            AppSpacing.lgPlus,
                            AppSpacing.lg,
                            AppSpacing.lgPlus,
                            AppSpacing.xl,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight:
                                  constraints.maxHeight -
                                  AppSpacing.lg -
                                  AppSpacing.xl,
                            ),
                            child: Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 620,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MizGlassInput(
                                      controller: _inputController,
                                      focusNode: _focusNode,
                                      semanticLabel: l10n.spatialHomeInputLabel,
                                      sendLabel: l10n.send,
                                      onChanged: _handleChanged,
                                      onSend: _canSend ? _submit : null,
                                      prominent: true,
                                      placeholder: MizPromptPlaceholder(
                                        prompts: prompts,
                                        controller: _inputController,
                                        focusNode: _focusNode,
                                        highContrast: true,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.xl),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MizGlassCircleButton(
                                          key: const ValueKey(
                                            'home-camera-action',
                                          ),
                                          icon: Icons.camera_rounded,
                                          semanticLabel: l10n.cameraAction,
                                          prominent: true,
                                          onPressed: () =>
                                              context.push(AppRoutes.camera),
                                        ),
                                        const SizedBox(width: AppSpacing.xl),
                                        MizGlassCircleButton(
                                          key: const ValueKey(
                                            'home-bookmarks-action',
                                          ),
                                          icon: Icons.bookmarks_rounded,
                                          semanticLabel: l10n.bookmarksAction,
                                          prominent: true,
                                          onPressed: () =>
                                              context.push(AppRoutes.bookmarks),
                                        ),
                                        const SizedBox(width: AppSpacing.xl),
                                        MizGlassCircleButton(
                                          key: const ValueKey(
                                            'home-profile-action',
                                          ),
                                          icon: Icons.account_circle_rounded,
                                          semanticLabel:
                                              l10n.profileSettingsAction,
                                          prominent: true,
                                          onPressed: () =>
                                              context.push(AppRoutes.profile),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
