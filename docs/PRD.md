# Product Requirements Document — Miz

Owner: Merlin ICT · Status: Foundation stage · Related: [`docs/DESIGN.md`](DESIGN.md), [`docs/ROADMAP.md`](ROADMAP.md)

## Vision

Food decisions are high-frequency, low-effort-tolerance decisions made under mild daily fatigue. Miz removes the friction of "what do I want, where do I get it, how do I get it" by acting as an AI assistant that asks a handful of sharp questions and answers with tappable, decision-ready interfaces — not paragraphs.

## Mission

Make deciding what to eat and getting it feel instant, personal, and effortless — on any given day, at any time of day — while staying a genuinely useful assistant rather than a novelty chat interface.

## Target users

- **Daily deciders**: people who eat out or order in multiple times a week and are fatigued by app-hopping between discovery, ordering, and reservation tools.
- **Explorers**: people new to an area (travel, relocation) who want fast, trustworthy local recommendations without research.
- **Planners**: people booking a table for an occasion who want a fast, low-friction reservation flow over calling a restaurant.

## Personas

1. **Alex, 29, urban professional.** Orders lunch delivery on weekdays, eats out 2–3x on weekends. Wants speed over browsing. Primary user of Home quick actions and the conversational flow.
2. **Priya, 34, frequent traveler.** Lands in a new city and wants nearby, well-reviewed options fast, with location-aware recommendations. Primary user of Discovery and location-based Home context.
3. **Marco, 41, plans dinners for others.** Books tables for dates and family dinners, cares about accurate availability and details (photos, menu, reviews) before committing. Primary user of Restaurant Details and Reservation.

## User stories

- As Alex, I want to open the app and immediately see relevant food options for right now (breakfast in the morning, dinner options in the evening) without typing anything.
- As Alex, I want to answer a few quick tappable questions instead of typing a full sentence, and see my answers as editable chips so I can change one without restarting.
- As Priya, I want the app to use my location automatically (once I grant permission) to show distance and ETA for nearby places.
- As Marco, I want to see a restaurant's rating, price, photos, menu highlights, and reviews before reserving, and complete a reservation in under 30 seconds.
- As any user, I want my preferences remembered (if I opt in) so the app asks fewer questions over time.
- As any user, I want core information (profile, favorites, recent searches) available even with a flaky connection.
- As any user, I want a clear, fast way to delete my data or my account from Settings.

## Business goals

- Establish Miz as a distinct, premium AI-native product in the Merlin ICT portfolio, independent of Mizzz.
- Drive repeat daily/weekly engagement through low-friction, high-relevance recommendations.
- Build an architecture that scales to millions of users without a rewrite (see `docs/ARCHITECTURE.md`).

## Functional requirements

- **Onboarding**: 3-step intro (value prop, location rationale, remember-preferences opt-in), skippable after step 1.
- **Home**: compact decision surface with the current offer first, a quick-action grid (Hungry, Order Food, Reserve a Table, Find a Café), optional favorites, and a persistent food-intent composer. Nearby browsing belongs in Discovery rather than adding another Home section.
- **Conversational flow (Summary Chips)**: a short sequence of tappable questions (cuisine, budget, distance, dietary) that collapse into editable chips; editing a chip re-enters the flow at that step without discarding later answers structurally (later answers reset, as in the approved prototype).
- **Generative UI / Results**: AI (or, pre-AI-integration, a scripted flow) selects and renders recommendation cards with rating, price, distance, ETA, and a one-line reason.
- **Restaurant details**: hero photo, rating/price/distance/open status, reserve/order actions, menu highlights, photo grid, a review, and an "Ask Miz about this restaurant" affordance.
- **Discovery**: map + filterable list view of nearby restaurants.
- **Menu browser**: search, category filter, add-to-cart, sticky cart summary, checkout.
- **Checkout**: cart review, delivery/pickup toggle, address/pickup info, place order.
- **Reservation**: date → time → guest count → confirm, with a confirmation screen.
- **Order tracking**: status steps (placed/preparing/on the way) with live map placeholder.
- **Profile/Settings**: working English/Farsi/German language selector, dark mode, notifications, location permission, remember-preferences, privacy, about, help, logout, delete data, delete account.
- **Offline**: profile, preferences, recent restaurants, bookmarks, recent searches, and conversation summaries remain available without connectivity.

## Non-functional requirements

- **Performance**: cold start under 2s on mid-tier devices; 60fps scroll on all list/rail screens.
- **Scalability**: stateless client-facing API surface, backend designed for horizontal scale (see `docs/ARCHITECTURE.md`).
- **Accessibility**: all interactive elements reachable and labeled for screen readers; minimum touch target 44×44.
- **Security & privacy**: no plaintext secrets, RLS-enforced data access, explicit consent for location and preference storage (see `docs/SECURITY.md`).
- **Reliability**: offline-cached core data must never show a blank/broken state.
- **Internationalization**: all interface copy and accessibility labels use typed ARB catalogs; English and German are LTR, Farsi is RTL, and adding a locale must not require feature-widget changes.

## Future vision (not built now — architected for)

Voice input, camera/vision-based dish recognition, OpenAI Realtime API for live conversation, RAG over restaurant knowledge, MCP-based tool integrations, multi-provider AI (not locked to OpenAI), group ordering, loyalty/rewards.

## Out of scope (for the current roadmap)

- Restaurant-side/merchant tooling (menu management, POS integration) — Miz is consumer-facing only.
- Payments processing implementation (checkout UI exists; real payment gateway integration is a later, separately-scoped milestone).
- Translated restaurant-authored/editorial content beyond the localized app interface; its API/database model is defined before live data integration.
- Social features (sharing, following other users).

## Success metrics / KPIs

- **Activation**: % of new installs completing onboarding and reaching Home.
- **Time-to-decision**: median time from opening the app to placing an order or completing a reservation.
- **Chip-flow completion rate**: % of started conversational flows that reach Results without abandonment.
- **Return rate**: 7-day and 30-day retention.
- **Recommendation acceptance**: % of Results-screen views that lead to an Order/Reserve tap.
- **Offline resilience**: % of sessions where cached data successfully served a screen during a connectivity gap.
