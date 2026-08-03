import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/bookmarks/bookmark_providers.dart';
import '../../../../core/bookmarks/saved_item.dart';
import '../../../../core/localization/localization.dart';
import '../../../../core/theme/app_glass.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/widgets.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final items = ref.watch(filteredSavedItemsProvider);
    final selectedFilter = ref.watch(savedItemsFilterProvider);
    final source = ref.watch(savedItemsProvider);

    return Scaffold(
      body: Stack(
        children: [
          const MizAnimatedFoodBackground(calm: true),
          SafeArea(
            child: Column(
              children: [
                _PageHeader(title: l10n.bookmarksTitle),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lgPlus,
                    AppSpacing.sm,
                    AppSpacing.lgPlus,
                    0,
                  ),
                  child: MizGlassSurface(
                    level: MizGlassLevel.primary,
                    prominent: true,
                    borderRadius: AppRadii.lg,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: TextField(
                      key: const ValueKey('bookmarks-search'),
                      onChanged: ref
                          .read(savedItemsQueryProvider.notifier)
                          .setQuery,
                      decoration: InputDecoration(
                        hintText: l10n.searchBookmarks,
                        hintStyle: const TextStyle(color: Colors.black54),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Colors.black54,
                        ),
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lgPlus,
                    ),
                    children: [
                      _FilterChip(
                        value: SavedItemFilter.all,
                        label: l10n.filterAll,
                        selected: selectedFilter,
                      ),
                      _FilterChip(
                        value: SavedItemFilter.restaurants,
                        label: l10n.filterRestaurants,
                        selected: selectedFilter,
                      ),
                      _FilterChip(
                        value: SavedItemFilter.foods,
                        label: l10n.filterFoods,
                        selected: selectedFilter,
                      ),
                      _FilterChip(
                        value: SavedItemFilter.menuItems,
                        label: l10n.filterMenuItems,
                        selected: selectedFilter,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: source.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    error: (_, _) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lgPlus),
                        child: MizResultCard(
                          title: l10n.localDatabaseErrorTitle,
                          body: l10n.localDatabaseErrorBody,
                          icon: Icons.storage_rounded,
                        ),
                      ),
                    ),
                    data: (_) => items.isEmpty
                        ? _EmptyBookmarks(
                            title: l10n.noBookmarksTitle,
                            body: l10n.noBookmarksBody,
                          )
                        : ListView.separated(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              AppSpacing.lgPlus,
                              AppSpacing.sm,
                              AppSpacing.lgPlus,
                              AppSpacing.xxl,
                            ),
                            itemCount: items.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: AppSpacing.md),
                            itemBuilder: (context, index) =>
                                _SavedItemRow(item: items[index]),
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

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lgPlus,
        AppSpacing.md,
        AppSpacing.lgPlus,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          const SizedBox(width: 48),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          MizFloatingDismissButton(
            semanticLabel: context.l10n.closePage,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends ConsumerWidget {
  const _FilterChip({
    required this.value,
    required this.label,
    required this.selected,
  });

  final SavedItemFilter value;
  final String label;
  final SavedItemFilter selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = selected == value;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        showCheckmark: false,
        backgroundColor: Colors.white,
        selectedColor: context.mizColors.accent,
        side: BorderSide.none,
        elevation: isSelected ? 7 : 4,
        shadowColor: Colors.black26,
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
        onSelected: (_) =>
            ref.read(savedItemsFilterProvider.notifier).select(value),
      ),
    );
  }
}

class _EmptyBookmarks extends StatelessWidget {
  const _EmptyBookmarks({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lgPlus),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: MizResultCard(
            title: title,
            body: body,
            icon: Icons.bookmark_border_rounded,
          ),
        ),
      ),
    );
  }
}

class _SavedItemRow extends ConsumerWidget {
  const _SavedItemRow({required this.item});

  final SavedItem item;

  IconData get _icon => switch (item.type) {
    SavedItemType.restaurant || SavedItemType.cafe => Icons.storefront_rounded,
    SavedItemType.menuItem => Icons.menu_book_rounded,
    SavedItemType.discovery => Icons.auto_awesome_rounded,
    SavedItemType.food || SavedItemType.scannedDish => Icons.restaurant_rounded,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mizColors;
    return MizGlassSurface(
      level: MizGlassLevel.secondary,
      prominent: true,
      borderRadius: AppRadii.lg,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colors.accent.withValues(alpha: 0.12),
            foregroundColor: colors.accent,
            child: Icon(_icon),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  item.subtitle ?? context.l10n.savedOffline,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: context.l10n.removeBookmark,
            onPressed: () =>
                ref.read(bookmarkRepositoryProvider).remove(item.type, item.id),
            icon: const Icon(Icons.bookmark_remove_rounded),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
