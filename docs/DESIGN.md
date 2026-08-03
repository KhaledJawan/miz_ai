# Design System & UX Model — Miz

Visual source of truth: [`DesignGD.md`](../DesignGD.md), design direction “Miz Spatial Glass.” It supersedes Soft Orbit for the immersive product shell while retaining Archivo, the semantic radius/spacing scale, Miz Mono Red, and the existing Food Profile interaction model.

Related: [`docs/PRD.md`](PRD.md), [`docs/ARCHITECTURE.md`](ARCHITECTURE.md), [`docs/API.md`](API.md).

## 1. Spatial Glass foundation

Miz is cinematic, calm, food-focused, and softly futuristic. Theme-aware culinary-AI artwork creates the atmosphere; the interaction plane stays solid white, black, neutral, and red.

- `subtle`, `secondary`, `primary`, `elevated`, `modal`, and `disabled` are the only glass levels.
- Blur, fill, border, highlight, shadow, dimming, contrast, motion, radii, and spacing are semantic tokens.
- Prominent controls, cards, result objects, and sheets are fully opaque white, zero blur, borderless, and use layered neutral iOS-style shadows.
- Black and gray foreground content is enforced inside white surfaces in both themes.
- Feature code does not provide one-off material values.
- Light mode uses a warm pale base; dark mode uses deep charcoal rather than pure black.
- Food photos may retain natural color, but UI gradients and shadows never become rainbow or multicolor.
- English/German are LTR and Farsi is RTL through one directional implementation.
- Icon actions have tooltips, semantics, focus/pressed states, and 44×44 minimum targets.

## 2. Component kit

Shared UI lives under `core/widgets/` with the `Miz` prefix. The Spatial Glass additions are:

| Component | Purpose |
|---|---|
| `MizGlassSurface` | Semantic surface with an approved solid-white prominent treatment and legacy glass levels |
| `MizGlassCircleButton` | Haptic, accessible circular contextual action |
| `MizGlassInput` | Multiline composer containing only text and send |
| `MizLocationCapsule` | Compact city state and selector entry point |
| `MizFloatingDismissButton` | Discoverable non-app-bar return/close control |
| `MizSpatialSheet` | Modal glass overlay with an opaque accessibility fallback |
| `MizResultCard` | Result, empty, unavailable, and error object |
| `MizCameraModeSelector` | Three-mode contextual camera selector |
| `MizAnimatedFoodBackground` | Isolated, lifecycle-aware abstract food atmosphere |
| `MizPromptPlaceholder` | Configurable localized fade rotation that pauses on interaction |
| `MizSpatialTransition` | Fade/0.98 scale page transition with reduced-motion fallback |

Existing `MizButton`, `MizCard`, `MizTag`, `MizOptionTile`, and Food Profile widgets remain valid. Feature widgets compose the kit and do not recreate its materials locally.

## 3. Home contract

Home contains exactly five conceptual elements:

1. Centered city capsule.
2. Central AI input.
3. Send action inside the input.
4. Exactly three unlabeled circular actions: camera, bookmarks, and profile/settings.
5. Theme-aware culinary-AI artwork with an approved 20% blur and slow ambient drift.

Home has no logo/header, greeting, offer, categories, feed, favorites rail, voice/camera/attachment action inside the field, label under the three actions, or bottom navigation. The composer moves above the keyboard and remains multiline. Empty prompts rotate by fade, pause on focus/typing, and localize through ARB.

## 4. Spatial navigation

There is no persistent bottom navigation or navigation rail. Root actions are contextual on Home. Secondary routes use a floating circular close control, Android system back, and the shared Spatial transition. No non-root Spatial screen uses a standard top-left app-bar arrow; the control placement mirrors with directionality.

Active routes:

- `/home`
- `/city`
- `/chat` (`?q=` is a validated deep-link input; `extra` is used for in-app prompts)
- `/camera`
- `/bookmarks`
- `/profile`
- `/food-profile`

Existing future routes remain stable and honest coming-soon surfaces.

## 5. City and privacy states

No city is assumed on first use. The selector supports manual search/selection, recent cities, a separately stored default city, clearing both selected/default state, and current-location states (`requesting`, `denied`, `unavailable`). Manual selection always works. The device adapter asks for foreground approximate location only after the user taps the control, maps coordinates locally to the nearest supported city within the service radius, and never stores or uploads coordinates.

## 6. Conversation

Submitting Home moves into a calmer spatial conversation view. User turns are solid black/white-type objects aligned to the directional end; Miz turns are white/black-type objects aligned to the directional start with a compact red AI marker. Messages have no repetitive copy affordance. Sending dismisses the keyboard and scrolls the newest state into view. The header contains History and New Chat, never a close/X control: both preserve a non-empty current thread in the local archive before leaving or clearing it. Typed service and state boundaries support loading, retry, local history review/deletion, future result saving/opening, new chat, and continued text input. Error objects are specific and actionable: timeout, temporary AI unavailability, rate limit, place-search failure, no results, and location required each have localized copy and the appropriate retry or city-selection action. The UI never presents those runtime failures as “not connected” and never shows provider details.

When AI results exist, food and restaurant responses render as `MizResultCard`-style UI objects and validated typed modes rather than raw model-controlled widget selection.

## 7. Camera

Camera is one shell with Food, Miz QR, and Menu modes. The shared state model covers permission, live, capture, preview, retake, processing, multiple matches, uncertainty, result, invalid/expired QR, denial, unavailable, offline, and error.

- Food recognition offers equal Take photo and Choose photo actions, a preview and explicit upload notice, then renders up to three typed candidates from the secure `analyze-food` adapter with confidence and an image-recognition safety disclaimer.
- Miz QR uses a real full-frame `mobile_scanner` preview for QR codes and accepts only `miz://v1/{restaurant|table}/…` payloads with safe public tokens, expiry, and signature shape. Invalid/expired codes offer Scan again. Local validation never grants trust; successful format validation still requires the future restaurant/table verification backend.
- Menu scan opens as the default camera mode. It offers equal, explicit Take photo and Choose photo actions, previews one to four pages, supports review/reorder/delete, and places a plain-language upload notice immediately above Explain menu. Results use readable section and dish cards with printed price, short explanation, dietary tags, possible-allergen warnings, and notes. Unreadable, oversized, unsupported, offline, timeout, and backend failures preserve the captured pages when retry is useful and never claim allergy safety.

Camera-created temporary captures are deleted by the capture service on removal or controller disposal; gallery originals are never deleted. No image is silently uploaded or persisted by Miz.

## 8. Bookmarks and Profile

Bookmarks is one unified, locally persistent saved-items space. It supports restaurants, cafés, foods, menu items, discoveries, and scanned dishes through a single Drift repository. Search and compact top filters replace bottom tabs. The legacy restaurant favorites controller writes to the same repository.

Profile and Settings is one grouped spatial page containing local profile/account status, a Food Profile summary and link, language, appearance, notifications, personalization, location, activity, privacy, help, and account availability. The existing Food Profile remains fully editable and retains its safety-critical separation between allergies, intolerances, restrictions, and taste preferences.

## 9. Motion, performance, and accessibility

Normal interaction/navigation is 100–420ms. Home uses one optimized theme-aware artwork asset at sigma `5.6`, isolated in a `RepaintBoundary`, precached, and paused when inactive/offscreen. Secondary routes reuse the artwork in a static, dimmed state. Foreground surfaces never run backdrop blur. Reduced motion stops drift and removes scale transitions.

All layouts use constraints, SafeArea, keyboard insets, directional APIs, lazy lists, text wrapping, semantic labels, visible non-gesture dismissal, and color-plus-icon/text state communication. Reference QA sizes are 390×844 and 320×720, including Farsi RTL and keyboard-open states.
