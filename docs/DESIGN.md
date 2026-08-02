# Design System & UX Model — Miz

Visual source of truth: [`DesignGD.md`](../DesignGD.md), design direction “Soft Orbit.” The earlier `Miz.dc.html` Modernist prototype remains a flow and content reference, but its square-only styling and grayscale image treatment are superseded by [ADR-010](DECISIONS.md).

Related: [`docs/PRD.md`](PRD.md), [`docs/ARCHITECTURE.md`](ARCHITECTURE.md), [`docs/API.md`](API.md).

## 1. Soft Orbit foundation

Miz is modern, focused, rounded, layered, and calm. Its interface uses black, white, neutral gray, and Miz red; natural food photography provides the only broad color range. Shape remains intentional rather than applying one radius everywhere:

- Circles: compact icon actions, avatars, voice, status, and map markers.
- Capsules: Summary Chips, filters, segmented controls, and short actions.
- Rounded rectangles: cards, forms, sheets, menus, and information-heavy surfaces.
- Superelliptical containers: hero modules and floating navigation/input surfaces.

Core implementation rules:

- Archivo 400/800 is bundled locally and remains the brand typeface.
- All colors, spacing, radii, shadows, and motion use semantic tokens.
- Light and dark themes are designed together.
- Food photography is warm and full color; grayscale is no longer a global brand treatment.
- Multicolor gradients and colored shadows are prohibited. At most one faint red ambient field may appear on a screen.
- Glass/blur is selective: floating navigation, composer, map controls, and immersive voice surfaces only.
- Every interaction has default, pressed, focused, disabled, selected/loading/error states where applicable.
- Minimum hit target is 44×44 and all icon-only actions have semantic labels.
- Reduced motion and reduced transparency receive stable fallbacks.
- Every component uses directional start/end layout primitives. English and German are LTR; Farsi mirrors the interface to RTL at the app root without separate screen implementations.

Exact tokens, component dimensions, transition timings, responsive rules, and page direction live in [`DesignGD.md`](../DesignGD.md).

## 2. Component kit

Shared UI lives under `core/widgets/` and uses the `Miz` prefix:

| Component | Purpose |
|---|---|
| `MizButton` | Pill primary, secondary, and ghost actions |
| `MizIconButton` | Circular icon action with a 44×44 minimum target |
| `MizCard` | Rounded tonal/elevated content surface |
| `MizTag` | Capsule filter and Summary Chip |
| `MizInput` | Rounded standard text field |
| `MizSegmentedControl` | Capsule single-select control |
| `MizSwitch` | Rounded accessible toggle |
| `MizDivider` | Quiet grouped-content separator |
| `MizImageSlot` | Full-color restaurant media with a monochrome/red fallback |
| `MizOrb` | AI presence for onboarding, Thinking, and voice states |

Feature widgets compose these components; they do not recreate their shape, focus, shadow, or state behavior locally.

## 3. Generative UI model

Miz is not a linear chat log. The AI—or the scripted flow before M7—selects the screen mode that best answers the user and supplies a typed payload:

`home · conversation · restaurant discovery · food discovery · recommendation · reservation · menu browser · restaurant details · comparison · checkout · tracking · map · settings`

The mode-selection contract is defined in [`docs/API.md`](API.md). Presentation receives validated typed models, never raw model text or `dynamic` JSON.

## 4. Summary Chip system

Summary Chips are the main conversational context model:

- Each answered question collapses into a tappable capsule above the current question.
- Chips replace a long chat history and remain horizontally scrollable.
- Tapping a chip reopens that step; all later answers reset with a clear transition.
- Results retain the choices as an editable filter row.
- Offline conversation summaries store the same structured choices.
- The current question uses the most suitable interface—chips, tiles, slider, map, calendar, or form—not repetitive message bubbles.

## 5. Home is compact and decision-first

Home avoids a long vertical dashboard. It presents the current offer first, then the four primary quick actions, followed only by Favorites when available. The persistent composer asks “What do you want to eat?” Home has no greeting hero, popular-cravings section, meal-period chip row, or Nearby rail; nearby browsing belongs in Discovery.

## 6. Motion model

Motion preserves context:

- Quick action expands into Conversation.
- Selected answer compresses into the Summary Chip rail.
- Edited chip expands back into its selection step.
- Thinking orb contracts into the Results header.
- Restaurant card image/title transition into Details where performance allows.
- Menu item feedback travels toward the floating cart summary.
- Reservation uses a shared-axis step transition with persistent progress.

Normal interaction and navigation range from 100–420ms. Ambient orb motion is slower and low amplitude. Reduced-motion mode replaces transforms, scale, parallax, and loops with short fades.

## 7. Screen inventory

Onboarding · Home · Conversation · Thinking · Results · Restaurant Details · Discovery (map/list) · Menu Browser and Cart · Reservation · Checkout · Order Tracking · Profile/Settings · Voice mode.

Page-specific composition and states are defined in [`DesignGD.md`](../DesignGD.md) §13–17. Unbuilt milestone routes remain honest “coming soon” screens; a redesign does not fake finished functionality.

## 8. Filling gaps

When an approved flow lacks a state, the UX role extends Soft Orbit rather than inventing another visual language. Recurring choices are recorded in [`docs/DECISIONS.md`](DECISIONS.md), and both design documents are updated when the pattern becomes part of the system.

Localized copy may expand significantly. Components allow flexible text, avoid fixed text widths, and are checked at 320 logical pixels in German and Farsi as well as English. Brand names and restaurant names keep their authored spelling; navigation, controls, units, cuisine labels, and semantics use the typed localization catalog.
