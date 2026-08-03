import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../theme/app_theme.dart';

class MizPromptPlaceholder extends StatefulWidget {
  const MizPromptPlaceholder({
    required this.prompts,
    required this.controller,
    required this.focusNode,
    this.interval = const Duration(seconds: 4),
    this.highContrast = false,
    super.key,
  });

  final List<String> prompts;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Duration interval;
  final bool highContrast;

  @override
  State<MizPromptPlaceholder> createState() => _MizPromptPlaceholderState();
}

class _MizPromptPlaceholderState extends State<MizPromptPlaceholder> {
  Timer? _timer;
  int _index = 0;

  bool get _canRotate =>
      widget.controller.text.isEmpty && !widget.focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleInteraction);
    widget.focusNode.addListener(_handleInteraction);
    _syncTimer();
  }

  @override
  void didUpdateWidget(covariant MizPromptPlaceholder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleInteraction);
      widget.controller.addListener(_handleInteraction);
    }
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode.removeListener(_handleInteraction);
      widget.focusNode.addListener(_handleInteraction);
    }
    if (_index >= widget.prompts.length) _index = 0;
    _syncTimer();
  }

  void _handleInteraction() {
    if (mounted) setState(_syncTimer);
  }

  void _syncTimer() {
    _timer?.cancel();
    if (!_canRotate || widget.prompts.length < 2) return;
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted || !_canRotate) return;
      setState(() => _index = (_index + 1) % widget.prompts.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.controller.removeListener(_handleInteraction);
    widget.focusNode.removeListener(_handleInteraction);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.prompts.isEmpty || widget.controller.text.isNotEmpty) {
      return const SizedBox.shrink();
    }
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return IgnorePointer(
      child: AnimatedSwitcher(
        duration: reduceMotion ? Duration.zero : AppMotion.slow,
        child: Text(
          widget.prompts[_index],
          key: ValueKey(_index),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: widget.highContrast
                ? Colors.black.withValues(alpha: 0.72)
                : context.mizColors.textSecondary,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}
