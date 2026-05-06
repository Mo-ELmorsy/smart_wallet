# SmartWallet 🚀

SmartWallet is an AI-powered personal finance tracker built with Flutter, applying Clean Architecture, Riverpod for state management, and GoRouter for routing.

## 🌟 Features

- **Auth & Security**: Onboarding, PIN setup, Biometrics fallback.
- **Transactions Management**: Track incomes, expenses, and transfers. Add, Edit, Delete with swipe gestures.
- **Budgets & Goals**: Set category-specific budgets with progress bars, and track long-term savings goals.
- **AI Insights**: Integrated with Gemini 1.5 Flash to automatically summarize your monthly spending patterns and offer personalized recommendations.
- **PDF Export**: Generate monthly professional financial reports in PDF.
- **Offline First**: All data is securely stored locally using Hive.

## 🛠 Tech Stack

- **Framework**: Flutter
- **Architecture**: Clean Architecture (Data, Domain, Presentation layers)
- **State Management**: Riverpod (`riverpod_annotation`, `flutter_riverpod`)
- **Routing**: GoRouter
- **Dependency Injection**: GetIt & Injectable
- **Local Storage**: Hive (NoSQL local DB)
- **Security**: Local Auth (Biometrics), SharedPreferences (PIN hashing via Crypto)
- **AI**: Google Generative AI (`google_generative_ai`)
- **PDF Generation**: `pdf` & `printing`

## 📂 Folder Structure

```
lib/
├── core/
│   ├── di/          # Dependency Injection (GetIt)
│   ├── error/       # Failure classes
│   ├── router/      # GoRouter configuration & App Shell
│   ├── theme/       # App themes
│   └── localization/
├── features/
│   ├── auth/        # Onboarding, PIN, Biometrics
│   ├── transactions/# Transaction lists, Dashboard, Categories
│   ├── budgets/     # Budgets, Goals, PDF Reports
│   └── insights/    # Gemini AI integration
└── main.dart
```

## 🚀 How to Run

1. Clone the repository.
2. Ensure you have the Flutter SDK installed (`^3.10.4`).
3. Run `flutter pub get`.
4. Run `dart run build_runner build -d` to generate Riverpod and Injectable dependencies.
5. Run `flutter run -d chrome` (or choose an emulator).

## 🤖 How to Add Gemini API Key

1. Launch the app and complete the initial setup (or log in).
2. Go to the **Dashboard**, tap the gear icon ⚙️ to open **Settings**.
3. Under the **AI Insights** section, tap "Gemini API Key".
4. Enter your API Key and tap Save.
5. Navigate back to the Dashboard and tap **AI Insights** to receive your financial summary!

## 🧪 Testing

To run the unit tests and widget tests, simply execute:
```bash
flutter test
```

## 📸 Screenshots

*Screenshots will be added after final UI capture.*

## 🛣 Future Improvements

- Full Cloud Sync (Firebase/Supabase).
- Advanced recurring transactions.
- Extensive Multi-month reporting capabilities.
