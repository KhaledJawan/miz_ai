# DesignGD — Miz Soft Orbit UI/UX Direction

Status: Approved and active. The shared system and implemented M0/M1 screens were migrated on 2026-08-01; future screens adopt this direction as their milestones begin.

This document defines the practical visual and interaction direction for the next version of Miz. It replaces the previous square-only execution guideline with a rounded, layered, calm, AI-native system inspired by the supplied references. It keeps Miz's product model from [docs/PRD.md](docs/PRD.md): decisions should be made through useful interfaces, not long chat transcripts.

The references are inspiration for shape, atmosphere, depth, and motion. Miz must remain recognizably a food and restaurant product rather than imitate a generic AI assistant.

## 1. Experience principles

### Focused intelligence

Miz should feel intelligent without visual noise. Use black, white, neutral gray, and Miz red for the interface; let natural food photography provide the only broad color range. Keep copy concise and human.

### Rounded, not bubbly

The new language uses continuous rounded corners, circular actions, capsules, and soft organic image masks. Rounding must express hierarchy:

- Circles for compact icon actions, avatars, status, voice, and map markers.
- Capsules for filters, Summary Chips, segmented controls, and short actions.
- Rounded rectangles for cards, forms, sheets, messages, and content containers.
- Large superelliptical containers for hero modules and floating navigation/input surfaces.

Do not make every object a pill. Large text-heavy surfaces need readable rounded rectangles.

### Layered clarity

Depth comes from tonal separation, blur, borders, and soft shadows. Each screen should have a clear base layer, content layer, and optional floating action layer. Decorative effects must never compete with restaurant information or primary actions.

### UI-first conversation

Miz remains a generative UI product. Prefer tappable choices, restaurant cards, comparisons, reservation controls, maps, and order states over long assistant paragraphs. Text chat is a supporting input method, not the dominant visual structure.

### Calm motion

Transitions should make context feel continuous. Elements expand, collapse, glide, and cross-fade from their source instead of screens appearing as unrelated pages.

## 2. Visual character

The intended mood is:

- Modern, focused, confident, and premium.
- Softly futuristic, but grounded in real food and real places.
- Spacious and editorial, without the severe brutalist edges of the previous system.
- Expressive in key moments and quiet during decision-heavy flows.

Avoid:

- Hard square cards and controls.
- Excessive glassmorphism or blur on every surface.
- Neon gradients behind body copy.
- Multicolor UI accents, rainbow gradients, or colored shadows.
- Heavy black shadows, skeuomorphic gloss, and plastic-looking controls.
- A screen full of unrelated radius values.
- Generic chat bubbles as the default response format.

## 3. Shape and radius system

Use a small semantic radius scale. Flutter tokens belong in `core/theme/app_radii.dart`; feature widgets must not introduce one-off values.

| Token | Value | Use |
|---|---:|---|
| `radius-xs` | 8 | Tiny indicators and compact nested elements |
| `radius-sm` | 12 | Tags, compact fields, small media |
| `radius-md` | 16 | List rows, standard fields, compact cards |
| `radius-lg` | 24 | Restaurant cards, banners, content panels |
| `radius-xl` | 32 | Sheets, hero modules, floating bars |
| `radius-2xl` | 40 | Large onboarding/AI spotlight surfaces |
| `radius-full` | 999 | Pills, avatars, icon buttons, circular actions |

Rules:

- Prefer continuous/superellipse-style corners where the platform supports them; otherwise use a consistent circular radius.
- A child surface should normally use a smaller radius than its parent.
- Media must clip to the same radius as its containing card edge.
- Full-screen pages do not need rounded outer corners; rounding belongs to surfaces within the safe area.
- Bottom sheets use `radius-xl` on the top corners and follow the device edge at the bottom.

## 4. Color system — Miz Mono Red

The interface palette is intentionally limited to black, white, neutral gray, and Miz red. Food photography may remain naturally colorful, but UI surfaces, shadows, illustrations, and decorative effects must not introduce additional hues. All values must become named theme tokens before use.

### Light theme

| Token | Value | Purpose |
|---|---|---|
| `bg-primary` | `#F7F7F5` | App background |
| `bg-secondary` | `#EDEDE9` | Section and grouped-content background |
| `surface-primary` | `#FFFFFF` | Primary cards and sheets |
| `surface-soft` | `#F1F1EE` | Inputs, quiet cards, inactive controls |
| `surface-glass` | `#FFFFFFE6` | Floating bars over visual content |
| `ink-primary` | `#111111` | Main text and dark actions |
| `ink-secondary` | `#555555` | Supporting text |
| `ink-tertiary` | `#858585` | Metadata and placeholders |
| `border-soft` | `#1111111A` | Hairline surface borders |
| `brand-primary` | `#D92D20` | Primary CTA and active state |
| `brand-deep` | `#A91F16` | Pressed state and accessible red text |
| `brand-tint` | `#FFE8E4` | Selected/featured background |
| `status-error` | `#A91F16` | Errors and destructive actions |
| `status-success` | `#292929` | Success text/icons; pair with an icon or label |

### Dark theme

| Token | Value | Purpose |
|---|---|---|
| `bg-primary` | `#0E0E0E` | Main background |
| `bg-secondary` | `#151515` | Grouped background |
| `surface-primary` | `#1B1B1B` | Primary cards and sheets |
| `surface-soft` | `#242424` | Inputs and nested surfaces |
| `surface-glass` | `#1B1B1BEB` | Floating bars |
| `ink-primary` | `#FFFFFF` | Main text |
| `ink-secondary` | `#C8C8C8` | Supporting text |
| `ink-tertiary` | `#929292` | Metadata and placeholders |
| `border-soft` | `#FFFFFF1F` | Hairline border |
| `brand-primary` | `#FF4B36` | Primary CTA and active state |
| `brand-deep` | `#FF7564` | Highlight on dark surfaces |
| `brand-tint` | `#461A15` | Selected/featured background |
| `status-error` | `#FF7564` | Errors and destructive actions |
| `status-success` | `#E4E4E4` | Success text/icons; pair with an icon or label |

### Ambient treatment

The interface does not use multicolor gradients. A single low-opacity red radial field may add depth to onboarding, Thinking, voice, or a selected hero; all other surfaces remain solid black, white, or neutral.

- `miz-red-glow`: brand red → transparent.
- Default opacity range: 6–14% in both themes.
- Shadows are neutral black only; never tint shadows with red or another hue.
- Keep body-copy regions on a stable surface color. If a gradient sits behind text, add a solid or sufficiently opaque content surface.
- Limit each screen to one subtle ambient field.

All text/background pairs and interactive states must pass WCAG AA. Color never carries meaning alone.

## 5. Typography

Keep Archivo as Miz's brand typeface, using the locally bundled font assets. The softer visual system comes from spacing, scale, weight, and shape—not from replacing the established typeface.

| Style | Size / height | Weight | Use |
|---|---|---:|---|
| Display | 34 / 40 | 800 | Onboarding and major hero statement |
| H1 | 28 / 34 | 800 | Page title |
| H2 | 24 / 30 | 800 | Major section |
| H3 | 20 / 26 | 800 | Card group or modal title |
| Title | 18 / 24 | 800 | Card title |
| Body L | 16 / 24 | 400 | Primary body and conversational prompt |
| Body M | 14 / 20 | 400 | Supporting copy |
| Label | 14 / 18 | 800 | Buttons, chips, tabs |
| Caption | 12 / 16 | 400 | Metadata |

Rules:

- Meaningful text never renders below 12 logical pixels.
- Use sentence case. Avoid all-caps labels except short category metadata.
- Keep assistant messages short and scannable.
- Use tabular figures for prices, distances, times, and ratings when available.

## 6. Spacing, grid, and density

Base spacing scale: `4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 / 48`.

- Standard mobile horizontal padding: 20; use 16 only on compact screens when required.
- Major section gap: 32.
- Card gap: 12–16.
- Standard card padding: 16–20.
- Minimum interactive hit target: 44×44.
- Primary controls: 52–56 high.
- Floating bottom content must include safe-area padding and never obscure the final list item.
- Design for the 390×844 reference frame first, then validate at 320 logical pixels and larger breakpoints.

Use asymmetry only for hero/editorial areas. Forms, menus, filters, and comparisons require strict alignment.

## 7. Depth, materials, and shadows

Use four material levels:

1. `base`: page background; no shadow.
2. `raised`: standard card; soft border plus subtle shadow.
3. `floating`: navigation, input dock, map control, sticky CTA; translucent or solid surface plus medium shadow.
4. `overlay`: modal/sheet; stronger shadow and scrim.

Suggested light-theme shadow tokens:

| Token | Shadow |
|---|---|
| `shadow-xs` | `0 1 2 #211D1A0A` |
| `shadow-sm` | `0 4 14 #5A46351A` |
| `shadow-md` | `0 10 30 #5A463526` |
| `shadow-lg` | `0 20 54 #5A463533` |

Dark mode uses lower-opacity black shadow plus a subtle light border so elevation remains visible.

Rules:

- Do not use the default Material elevation appearance.
- A card usually uses one subtle border and one soft shadow; avoid stacked dark outlines.
- Glass surfaces are reserved for floating navigation, voice controls, map controls, and the composer over imagery.
- Glass requires a fallback opaque surface for reduced transparency, performance constraints, and contrast.
- Blur radius should remain restrained (approximately 16–24); large animated blur fields must be profiled.

## 8. Photography and illustration

Food photography is full color in the new direction. Images should feel warm, natural, and appetizing.

- Use consistent 4:3 or 3:2 media ratios for restaurant cards.
- Hero media may use 4:5 or edge-to-edge crops.
- Apply a subtle warm color grade; do not force grayscale.
- Use a bottom scrim only where text or controls overlay photography.
- Loading placeholders use soft tonal gradients and a low-motion shimmer.
- Empty states can use simple circular/organic illustrations derived from food, plates, location, and the Miz orb.
- Never stretch images or place essential text over visually busy areas without a stable surface.

## 9. Core component language

### Buttons

- Primary: 52 high, `radius-full`, brand fill, high-contrast label, optional trailing icon.
- Secondary: 48–52 high, `radius-full`, surface fill, soft border.
- Tertiary: text/icon action with a 44×44 minimum hit area.
- Destructive: quiet by default; error color becomes stronger only at confirmation.
- Pressed state: 0.98 scale plus tonal shift within 100ms.
- Disabled state: reduced contrast, no accent shadow, tap blocked.

### Icon buttons

- Visual circle: 40 or 44; hit target is always at least 44.
- Use 20–22 icons with consistent stroke weight.
- Primary send/voice actions may use a 48–56 circle.

### Cards

- Standard card: `radius-lg`, surface fill, `shadow-sm`, optional soft border.
- Feature/hero card: `radius-xl`, may use an ambient gradient or large image.
- Horizontal restaurant card: rounded thumbnail, aligned facts, one clear action.
- Avoid nesting more than two raised cards; use tonal groups inside a card instead.

### Chips and filters

- Height: 36–40; `radius-full`; horizontal padding 14–16.
- Selected chips use a tinted accent surface plus icon/check where useful.
- Summary Chips may use cuisine-related accent tints, but the selected state remains consistent.
- Long labels truncate gracefully and retain a semantic full label.

### Inputs and composer

- Standard field: 52 high, `radius-lg` or `radius-full` depending on context.
- Conversational composer: floating `radius-xl` dock with text, add, voice, camera, and send actions.
- Disabled future actions remain visible, labeled, and clearly inactive.
- Keyboard opening must smoothly lift the composer without jumping the page.

### Navigation

- Use a floating rounded bottom navigation dock for the primary destinations only when more than two persistent destinations exist.
- Active destination uses a filled circle/capsule and text label where space allows.
- Detail and task flows use a compact top bar with circular back and overflow actions.
- Do not show bottom navigation during checkout, reservation confirmation, voice focus, or other immersive tasks.

### Sheets and dialogs

- Prefer bottom sheets for mobile filters, settings, cart summaries, and short confirmations.
- Use `radius-xl` top corners, visible drag affordance when draggable, and a clear title/action hierarchy.
- Destructive dialogs require explicit confirmation and must not rely on color alone.

## 10. Miz orb and AI presence

The reference imagery uses a soft glowing orb to represent intelligence. Miz may use a distinct orb as a supporting brand behavior:

- Form: concentric black, red, and white circles with a neutral shadow.
- Resting: subtle slow drift or breathing at very low amplitude.
- Thinking: gentle color rotation and scale pulse.
- Listening: responsive concentric waveform/ring.
- Success: brief settle and warm highlight.

The orb appears on onboarding, Thinking, voice mode, and small assistant status markers. It must not appear beside every card or become decorative clutter. Respect reduced motion by replacing animation with a static state.

## 11. Motion and transitions

### Timing tokens

| Token | Duration | Use |
|---|---:|---|
| `motion-instant` | 100ms | Pressed feedback |
| `motion-fast` | 180ms | Chip/button state, small fades |
| `motion-standard` | 280ms | Card changes, sheet content |
| `motion-slow` | 420ms | Page transition, hero expansion |
| `motion-ambient` | 1200–3000ms | Orb/gradient breathing only |

Use emphasized ease-out for entrances and standard ease-in-out for rearrangement. Avoid bouncy spring motion in payment, reservation, settings, or error flows.

### Required transitions

- Home quick action → Conversation: selected action expands into the first prompt header.
- Answer → Summary Chip: choice compresses and moves into the chip rail; next question fades/slides up.
- Summary Chip edit: tapped chip expands back into its selection panel; later chips fade/slide away.
- Thinking → Results: orb contracts into the result header while cards enter with a short stagger.
- Restaurant card → Details: shared hero image and title transition where platform performance allows.
- Add to cart: item image/indicator moves toward the sticky cart summary; quantity updates without reloading the list.
- Reservation steps: horizontal shared-axis transition with persistent progress.
- Sheet open/close: spring-like position settling with a restrained fade scrim.
- Theme change: cross-fade theme surfaces; do not animate every descendant independently.

Rules:

- Keep normal navigation between 220–420ms.
- Stagger no more than 3–4 visible items and no more than about 40ms apart.
- Never block input while decorative animation finishes.
- Respect platform reduced-motion settings: replace movement, scale, parallax, and ambient looping with short fades.
- Profile blur, large images, lists, and shared-element transitions to maintain 60fps.

## 12. Generative UI and conversation model

The Summary Chip system remains central, but adopts the new rounded language:

- Chips form a horizontally scrollable context rail below the compact conversation header.
- The current question occupies a spacious rounded panel with one obvious next action.
- Options appear as large chips, visual tiles, sliders, or maps depending on the question—not as repetitive chat bubbles.
- Editing a chip returns to that step and resets later answers, with an explanatory transition rather than an abrupt disappearance.
- Results retain the summary as an editable filter row.
- Assistant prose should usually remain under three short sentences before structured actions.

The AI/UI contract remains typed and validated. Visual redesign does not permit raw model output to control navigation or widgets directly.

## 13. Page direction

### Onboarding

- Full-screen monochrome canvas with one subtle red ambient field and the Miz orb or food/location visual.
- Large, friendly statement; minimal body copy; one pill primary CTA.
- Progress uses a compact capsule or animated dots near the CTA.
- Permission explanations appear before the system dialog and clearly offer “Not now.”

### Home

- Focused monochrome header with circular profile action and location capsule.
- Place the current offer directly below the header; do not add a separate greeting hero.
- Keep the four primary actions immediately after the offer, using black/white rounded cards with one restrained red featured state.
- Favorites may use a horizontal restaurant rail when non-empty; Nearby results belong in Discovery and do not add length to Home.
- Offers use a solid red banner with high-contrast white content; no gradient, flashing, or auto-advance.
- Do not add Popular Cravings or meal-period chip sections to Home; preference refinement belongs in Conversation/Results.
- The persistent composer asks “What do you want to eat?” so its purpose is explicit.
- Floating navigation/composer must not cover content.

### Conversation

- Compact header, Summary Chip rail, current-question panel, and floating composer.
- Background may use a very faint red field, while answer controls sit on stable monochrome surfaces.
- Typed input stays available without turning the page into a long chat transcript.
- Thinking uses the Miz orb and an honest, concise status message.

### Results and recommendations

- Lead with a human summary and editable filters.
- First recommendation can use a larger feature card; alternatives use consistent standard cards.
- Cards show image, name, cuisine, rating, price, distance/ETA, open state, and one concise “Why Miz picked it” line.
- Order and Reserve actions reflect actual restaurant capabilities.

### Restaurant details

- Immersive rounded hero image with floating circular back, favorite, and share actions.
- Core facts appear in a compact capsule row.
- Sticky bottom action surface contains Reserve/Order based on availability.
- Menu highlights, photos, and reviews use rounded sections with clear headings—not nested card clutter.

### Discovery and map

- Map and list transition through a capsule segmented control.
- Map markers are circular brand pins with selected raised state.
- Filter chips float in a horizontally scrolling glass/surface row.
- A selected restaurant appears in a bottom preview card; dragging into the list should feel continuous.

### Menu and cart

- Sticky category capsules; large food rows/cards with image, price, dietary tags, and circular add control.
- Quantity editing is inline and immediately reflected in the floating cart summary.
- The cart summary is a rounded floating bar with total and clear next action.

### Checkout

- Quiet surface with minimal decorative gradients.
- Group address, fulfillment, order, and payment-placeholder sections in readable rounded panels.
- Keep totals persistent near the final CTA.
- Errors appear inline at the responsible field; never discard entered data.

### Reservation

- Visible progress capsule: Date → Time → Guests → Confirm.
- Dates and times use generous circular/capsule selections.
- Confirmation uses a restrained success moment, clear booking details, calendar action, and route back to the restaurant.

### Tracking

- Map/route hero with a rounded status sheet.
- Status timeline uses circular checkpoints and explicit text.
- Contact/help actions remain visible without obscuring the map.

### Profile and settings

- Full-height rounded sheet or page with grouped tonal sections.
- Profile uses a circular avatar and concise account summary.
- Toggles, permissions, and privacy choices include explicit supporting text where consequences matter.
- Delete Data and Delete Account are separated and require confirmation.

### Voice mode

- Immersive, low-information screen with the Miz orb, listening/speaking state, live transcript, and clear exit.
- Camera and keyboard alternatives remain accessible as circular bottom actions.
- No constantly moving background when reduced motion is enabled.

## 14. Interaction states

Every interactive component needs:

- Default.
- Pressed.
- Focused with a visible non-color-only indicator.
- Selected where applicable.
- Disabled.
- Loading when an action is asynchronous.
- Error and retry where failure is possible.

Loading behavior must preserve layout. Use skeletons for content, inline progress for local actions, and full-screen Thinking only for genuine AI orchestration.

## 15. Accessibility and inclusive behavior

- Minimum 44×44 hit target, even when the visible circle is smaller.
- WCAG AA contrast for text, controls, focus, and status information.
- Semantics labels for every icon-only control, chip remove/edit action, map marker, and image action.
- Logical focus order matching visual order.
- Dynamic text must not clip primary actions or hide critical information.
- Voice and gesture interactions always have tap/text alternatives.
- Do not communicate price level, dietary suitability, open state, or order status through color alone.
- Support reduced motion and reduced transparency when available.

### Localization and bidirectionality

- English and German use LTR; Farsi uses RTL. Locale selection at the application root controls direction for every route, sheet, dialog, and semantic node.
- Use start/end rather than hard-coded left/right for alignment, padding, positioning, chevrons, and transition origins.
- The same component tree serves LTR and RTL. Do not create Farsi-only screen copies or manually reverse Row children.
- Allow for German expansion and natural Persian line breaking. Controls grow or wrap before truncating essential actions.
- Numeric restaurant facts use localized units while ratings, prices, and authored restaurant names remain recognizable.
- Archivo remains the Latin brand face; Persian glyphs use the platform's Noto-compatible Arabic fallback until a bundled Persian family is approved and licensed.

## 16. Responsive behavior

- Compact phones: preserve the primary action and facts; allow chips to scroll; avoid squeezed two-column content.
- Standard phones: use the 390×844 reference composition.
- Large phones/tablets: constrain reading width, increase gutters, and use adaptive two-pane layouts for map/list, menu/cart, or settings/detail where useful.
- Web/desktop: surfaces may float within a centered canvas; do not simply stretch mobile cards edge to edge.

## 17. Screen quality checklist

Every changed screen must pass:

1. Uses semantic radius, color, spacing, shadow, and motion tokens only.
2. Has one obvious primary action.
3. Rounded hierarchy is consistent; not every surface is a pill.
4. Ambient gradient is limited and never harms readability.
5. Light and dark themes are intentionally composed.
6. Default, pressed, focused, disabled, loading, empty, error, and retry states are covered where applicable.
7. No overflow at 320 logical pixels; validated first at 390×844.
8. Touch targets, semantics, focus order, and contrast are verified.
9. Reduced motion/transparency behavior is defined.
10. Scroll, blur, imagery, and transitions maintain 60fps.
11. Content remains usable offline when required by the PRD.
12. The page still behaves like Miz—a food decision interface—not a generic AI chat product.

## 18. Redesign implementation order

1. Align sources of truth: update `CLAUDE.md`, `docs/DESIGN.md`, and `docs/DECISIONS.md`; retire the older prototype's square styling while retaining its useful flow references.
2. Token migration: color, radius, shadow, motion, typography, and spacing tokens for both themes.
3. Component migration: buttons, icon buttons, cards, chips, inputs, composer, navigation, sheets, image treatment, and the Miz orb.
4. Foundation screens: onboarding, Home, profile/settings.
5. Generative UI flow: Conversation, Summary Chips, Thinking, Results.
6. Restaurant journey: Discovery, Details, Menu, Reservation, Checkout, Tracking.
7. State completion: loading, empty, error, offline, disabled, and permission-denied states.
8. Accessibility, reduced-motion, dark-mode, and responsive audit.
9. Visual QA against approved redesign frames on small phones first, then larger devices.
10. Performance profile and final documentation sync before declaring a milestone complete.

Do not mix the old square component language and the new Soft Orbit language within a released screen. Migrate by complete component family and validate each affected flow before moving on.
