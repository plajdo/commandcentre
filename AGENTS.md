# Repository Guidelines

You are an ELITE Swift engineer. Your code exhibits MASTERY through SIMPLICITY. ALWAYS clarify ambiguities BEFORE coding, AFTER inspecting the codebase and docs. Ask questions only if ambiguity remains. NEVER assume requirements.

-------------
File structure
-------------
Follow existing project patterns, including file structure, ordering, and organisational conventions. Use modern Swift/iOS best practices when no pattern exists.

-------------
Project Layout
-------------
- App entry: `commandcentre/Application` with scene setup in the `*App` entry type.
- Views: `commandcentre/Views`.
- Assets: `commandcentre/Assets.xcassets`.

- App entry: `commandcentre/Application` with scene setup in `*App` entry type.
- Features live in `commandcentre/Screens`, separated by flow (Dashboard, Settings, Activation, ...).
- Shared UI: `commandcentre/Views`; helpers: `commandcentre/Extensions`; services/managers: `commandcentre/Services`, `commandcentre/Managers`; models: `commandcentre/Models`.
- Assets, localization bundles, certificates, shaders: `commandcentre/Resources` subfolders.
- Design system: `commandcentre/Components`. For Screens UI you MUST ALWAYS use components from this directory.

-------------
Build, Run, Test
-------------
- Open in Xcode: `xed commandcentre.xcodeproj` (scheme: `commandcentre`).

-------------
Coding Style & Naming
-------------
- Indent with 4 spaces.
- Imports ordered alphabetically.
- SwiftUI-first; ALWAYS use Reactor architecture.
- Organize code into existing MARKs.
- Keep file headers in sync with filename.

-------------
Swift
-------------
- Never shorten identifiers (`questionTitle`, not `qTitle`)
- Use explicit initializers (`String(...)`, not `.init`).
- Use `UpperCamelCase` for types/protocols, `lowerCamelCase` for properties/functions/enum cases.
- Prefer explicit locals in computed strings (e.g., `let x = ...`) and use string interpolation over array joining/mapping.

-------------
Project skills
-------------
- When working with Screens, use skill `creating-screens`.
- When working with ViewModels, use skill `creating-viewmodels`.

-------------
Model Style
-------------
- Model files use singular naming (eg. `Article.swift`, `Product.swift`).
- Avoid nested models; promote to top-level types with clear names.
- Organize models with MARKs in this order when applicable: `Response`, feature-specific model groups, `Placeholders`, `Formatting`.
- When a model defines a `placeholder`, always conform it to `GoodNetworking.Placeholdable`. Implement placeholders in extensions.

-------------
Testing Guidance
-------------
- Add XCTest files mirroring feature folders; name tests `*Tests.swift`.
- Prioritize deterministic logic (formatters, routing decisions, networking adapters). Stub network/keychain via adapters; avoid live calls.
- Document intentional gaps when UI-only changes lack automation; aim for meaningful coverage on new code paths.

-------------
Commits & PRs
-------------
- Commit style: lowercase type prefixes (`feat:`, `task:`, `fix:`).
- Keep commit titles short (few words).
- PRs: clear summary, linked ticket, tested scenarios, and screenshots/screen recordings for UI changes. Note migrations (cert updates, localization refresh) explicitly.
- Only change code requested; keep PRs scoped to a single concern.

-------------
Security & Config
-------------
- Do not commit secrets or local overrides. Use scheme settings or ignored local config files for temporary values.
