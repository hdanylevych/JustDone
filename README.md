# JustDone – Modular SwiftUI App

JustDone is an iOS application structured using a **modular architecture** built with Swift Packages.  
The codebase is divided into four clear architectural layers:

- **Domain** – core models and interfaces  
- **Infrastructure** – concrete service implementations  
- **Composition** – dependency wiring (DI)  
- **Features** – UI screens and business logic  

This separation improves testability, scalability, and code clarity.

---

## 📚 Domain

The **Domain** layer contains the foundational logic that everything else depends on.

### **Core**
- Domain models
- Protocols and abstractions
- Navigation types
- Shared extensions and view modifiers

### **DesignSystem**
- Icon library (`DSIcon`)
- Asset catalogs
- Fonts, colors, and reusable UI primitives

**Responsibilities:**  
Provide interfaces, shared types, and global UI resources.  
Domain never depends on Infrastructure or Features.

---

## 🛠 Infrastructure

The **Infrastructure** layer contains real service implementations.  
It may depend only on **Domain**, since Domain contains all interfaces.

### **Persistence**
- Core Data stack (`PersistenceController`)
- `DatabaseService` implementation
- Data model and persistent storage

### **Utils**
- Permissions service
- Speech recognition service
- Miscellaneous reusable helpers

**Responsibilities:**  
Provide concrete system-level functionality without referencing Features.

---

## 🔗 Composition

### **InfrastructureDI**

This module wires the **Infrastructure implementations** to **Domain interfaces** using `Factory`.

Contains:
- `PersistenceComposition`  
- `UtilsComposition`  

**Responsibilities:**  
- Register concrete services for Dependency Injection  
- Provide DI access to Features without exposing Infrastructure directly  
- Isolate dependency wiring from the app and feature modules  

Features import **InfrastructureDI**, not Persistence/Utils directly.

---

## 🧩 Features

Feature modules represent application screens and business logic.  
They depend only on **Domain** and **Composition (InfrastructureDI)**.

### **Home**
- `HomeView`, `HomeVM`
- Uses injected services (e.g., fetching data)
- Navigates using the Router provided by the App

### **Chat**
- `ChatView`, `ChatVM`, `MessageView`
- Handles displaying and interacting with messages
- Uses domain interfaces via DI

**Responsibilities:**  
Provide UI and user-driven logic without knowing about concrete Infrastructure.

---

## 📱 App Target

The **JustDone** app target contains:

- `JustDoneApp` — app entry point
- `RootView` — main container view
- `Router` — global navigation manager (`@Observable`)
- Application-wide environment injection

**Responsibilities:**  
- Initialize navigation  
- Provide the Router to the view hierarchy  
- Start the app and bootstrap dependency composition  

---

## 🧭 Summary

This architecture ensures:

- **Domain** defines stable interfaces  
- **Infrastructure** provides real implementations but stays hidden  
- **InfrastructureDI** cleanly wires concrete services to abstract protocols  
- **Features** remain lightweight, testable, and independent of Infrastructure  
- **App** handles startup, navigation, and root environment setup  

The result is a clean, scalable, and maintainable modular SwiftUI application.

---
