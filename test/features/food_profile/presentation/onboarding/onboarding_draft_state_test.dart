import 'package:flutter_test/flutter_test.dart';
import 'package:miz_ai/features/food_profile/domain/entities.dart';
import 'package:miz_ai/features/food_profile/domain/food_profile_enums.dart';
import 'package:miz_ai/features/food_profile/presentation/onboarding/onboarding_draft_state.dart';

const _ingredients = [
  IngredientEntry(
    id: 1,
    code: 'beef',
    parentId: 100,
    category: 'meat',
    isAnimalProduct: true,
    isMeat: true,
    isSeafood: false,
    isAlcoholRelated: false,
  ),
  IngredientEntry(
    id: 2,
    code: 'salmonFish',
    parentId: 101,
    category: 'seafood',
    isAnimalProduct: true,
    isMeat: false,
    isSeafood: true,
    isAlcoholRelated: false,
  ),
  IngredientEntry(
    id: 3,
    code: 'tofu',
    parentId: 102,
    category: 'plantProtein',
    isAnimalProduct: false,
    isMeat: false,
    isSeafood: false,
    isAlcoholRelated: false,
  ),
  IngredientEntry(
    id: 4,
    code: 'cheese',
    parentId: 103,
    category: 'dairy',
    isAnimalProduct: true,
    isMeat: false,
    isSeafood: false,
    isAlcoholRelated: false,
  ),
];

OnboardingDraftState _stateWithDiet(DietType diet) => OnboardingDraftState(
  screenIndex: OnboardingScreen.proteins.index,
  dietType: diet,
  allergenCatalog: const [],
  intoleranceCatalog: const [],
  foodRuleCatalog: const [],
  ingredientCatalog: _ingredients,
  cuisineCatalog: const [],
  flavorCatalog: const [],
  foodItemCatalog: const [],
);

void main() {
  group('OnboardingDraftState.visibleProteinIngredients (adaptive skip)', () {
    test('vegan hides both meat and seafood', () {
      final visible = _stateWithDiet(DietType.vegan).visibleProteinIngredients;
      final codes = visible.map((i) => i.code).toSet();

      expect(codes, isNot(contains('beef')));
      expect(codes, isNot(contains('salmonFish')));
      expect(codes, containsAll(['tofu', 'cheese']));
    });

    test('vegetarian hides both meat and seafood', () {
      final visible = _stateWithDiet(
        DietType.vegetarian,
      ).visibleProteinIngredients;
      final codes = visible.map((i) => i.code).toSet();

      expect(codes, isNot(contains('beef')));
      expect(codes, isNot(contains('salmonFish')));
    });

    test('pescatarian shows seafood but hides meat', () {
      final visible = _stateWithDiet(
        DietType.pescatarian,
      ).visibleProteinIngredients;
      final codes = visible.map((i) => i.code).toSet();

      expect(codes, isNot(contains('beef')));
      expect(codes, contains('salmonFish'));
    });

    test('omnivore shows everything', () {
      final visible = _stateWithDiet(
        DietType.omnivore,
      ).visibleProteinIngredients;
      final codes = visible.map((i) => i.code).toSet();

      expect(codes, containsAll(['beef', 'salmonFish', 'tofu', 'cheese']));
    });
  });

  group('OnboardingDraftState navigation getters', () {
    test(
      'hasSevereAllergy is true only when an active severe allergy draft exists',
      () {
        final noneState = _stateWithDiet(DietType.omnivore);
        expect(noneState.hasSevereAllergy, isFalse);

        final withMild = noneState.copyWith(
          allergies: {
            'a1': const AllergyDraft(
              allergenId: 1,
              severity: AllergySeverity.mild,
            ),
          },
        );
        expect(withMild.hasSevereAllergy, isFalse);

        final withSevere = noneState.copyWith(
          allergies: {
            'a1': const AllergyDraft(
              allergenId: 1,
              severity: AllergySeverity.severe,
            ),
          },
        );
        expect(withSevere.hasSevereAllergy, isTrue);
      },
    );

    test('showSkip is only true on the first (welcome) screen', () {
      final welcome = _stateWithDiet(
        DietType.omnivore,
      ).copyWith(screenIndex: OnboardingScreen.welcome.index);
      final diet = welcome.copyWith(screenIndex: OnboardingScreen.diet.index);

      expect(welcome.showSkip, isTrue);
      expect(diet.showSkip, isFalse);
    });

    test('isFirstScreen and isLastScreen bound the flow correctly', () {
      final first = _stateWithDiet(
        DietType.omnivore,
      ).copyWith(screenIndex: OnboardingScreen.welcome.index);
      final last = first.copyWith(screenIndex: OnboardingScreen.review.index);

      expect(first.isFirstScreen, isTrue);
      expect(first.isLastScreen, isFalse);
      expect(last.isLastScreen, isTrue);
      expect(last.isFirstScreen, isFalse);
    });
  });
}
