# JustDone – Modular SwiftUI App

JustDone is an iOS application built using a **full modular architecture** based on Swift Packages.  
Each module has a clear responsibility and communicates with others through well-defined boundaries.  
The goal is maintainability, testability, and feature isolation.

---

## 📦 Project Modules

Below is a breakdown of every module in the project and its purpose.

---

## **1. JustDone (App Target)**

This is the main application bundle.

Contains:
- `JustDoneApp` — the entry point of the app
- `RootView` — top-level container view with `NavigationStack`
- `Router` — global navigation manager (`@Observable`) injected into the environment

Responsibilities:
- Launching the app
- Creating and injecting the `Router`
- Setting up global environment values
- Hosting the entire navigation tree

---

## **2. AppDI (Swift Package)**

This module is the **composition root** of the app.

Contains:
- All **Factory** dependency registrations
- Composition helpers (`PersistenceComposition`, `UtilsComposition`)
- Global environment entries (`@Entry`) when needed

Responsibilities:
- Wiring all dependencies together
- Registering concrete implementations for services
- Providing DI access to other modules through Factory

This module knows about:
- Core protocols
- Concrete implementations (Persistence, Utils)

Other modules depend on AppDI to get their dependencies injected.

---

## **3. Core (Swift Package)**

This is the **domain layer** and the shared foundation.

Contains:
- Domain models (e.g., Chat, Message)
- Protocols and abstractions
- Shared utilities
- Navigation types (e.g., `RouterDestination`)
- Common extensions and modifiers

Responsibilities:
- Define the stable API that other modules depend on
- Provide all shared, non-UI logic
- Contain no concrete implementations

Core has **no dependencies** — everything depends on Core.

---

## **4. Home (Swift Package)**

Feature module for the Home screen.

Contains:
- `HomeView`
- `HomeVM` (`@Observable`)
- Local feature UI and logic

Responsibilities:
- Render the Home screen
- Fetch data via injected services (via Factory)
- Use the router (injected from App target via environment)

Home depends only on:
- Core
- AppDI
- DesignSystem

---

## **5. Chat (Swift Package)**

Feature module for the Chat screen.

Contains:
- `ChatView`
- `ChatVM`
- `MessageView`

Responsibilities:
- Render conversations
- Fetch/save messages using injected services
- Navigate via global Router

---

## **6. Persistence (Swift Package)**

This is the **data layer**.

Contains:
- `DatabaseService` — Core Data service implementation
- `PersistenceController` — Core Data stack setup
- Data entities and resources

Responsibilities:
- Provide real data storage
- Manage Core Data context and model loading
- Expose data access via abstractions defined in Core

Only AppDI wires Persistence into DI.

---

## **7. DesignSystem (Swift Package)**

A shared UI component & asset library.

Contains:
- Icons (`DSIcon`)
- Asset catalogs
- Color palettes, fonts, styles

Responsibilities:
- Provide consistent, reusable UI components
- Centralize app styling
- Provide resource bundles

---

## **8. Utils (Swift Package)**

Collection of small reusable utilities.

Contains:
- Permission handler
- Speech recognizer wrapper
- Miscellaneous helpers

Responsibilities:
- Provide non-feature-specific utility logic
- Remain modular and lightweight
- Offer services that can be reused across features

---

## 🧩 Architecture Summary

- App uses **SwiftUI** + **Observation (`@Observable`)** for state.
- All modules are isolated using **Swift Package Manager**.
- `AppDI` acts as the **central dependency injection root** using **Factory**.
- `Router` is a concrete `@Observable` class located in the App target and injected via environment.
- Feature modules (Home, Chat) are lightweight and depend only on:
  - Core  
  - AppDI  
  - DesignSystem
