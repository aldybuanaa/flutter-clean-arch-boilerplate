# 🚀 Flutter Clean Architecture + BLoC Boilerplate

Boilerplate ini adalah fondasi standar industri untuk membangun aplikasi Flutter yang *scalable*, *testable*, dan mudah di-maintain. Proyek ini menggunakan **Clean Architecture** yang dipadukan dengan **BLoC** untuk *State Management*.

## 🛠️ Tech Stack & Dependencies
* **Framework:** Flutter
* **State Management:** `flutter_bloc`
* **Dependency Injection:** `get_it`
* **Networking:** `dio`
* **Functional Programming (Error Handling):** `dartz`
* **Value Equality:** `equatable`

---

## 📂 Struktur Direktori (Folder Structure)
Proyek ini memisahkan secara tegas antara kode inti (`core`) dan fitur spesifik (`features`).

```text
lib/
├── core/
│   ├── error/              # Failure, Exceptions
│   ├── usecases/           # Base UseCase class
│   ├── network/            # Network info (Internet connection checker)
│   └── utils/              # Constants, Colors, Themes, Helpers
├── features/
│   └── [feature_name]/     # Tiap fitur memiliki 3 layer ini
│       ├── data/
│       │   ├── datasources/ (Remote & Local API calls)
│       │   ├── models/      (JSON serialization, extends Entity)
│       │   └── repositories/(Implementasi kontrak Domain)
│       ├── domain/
│       │   ├── entities/    (Core business objects)
│       │   ├── repositories/(Kontrak/Interfaces)
│       │   └── usecases/    (Business logic execution)
│       └── presentation/
│           ├── bloc/        (State management)
│           ├── pages/       (UI Screens)
│           └── widgets/     (Reusable UI components for this feature)
├── injection_container.dart # Setup GetIt (Service Locator)
└── main.dart