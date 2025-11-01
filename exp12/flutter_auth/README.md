
## 📱 Flutter Firebase Auth App

A beautiful, multi-provider authentication app built with Flutter and Firebase. Supports phone number OTP login, Google sign-in, and email/password authentication — all wrapped in a clean, aesthetic UI.

---

### 🚀 Features

- 🔐 Firebase Authentication (Phone, Google, Email/Password)
- 📲 OTP verification with SMS auto-retrieval support
- 🌈 Gradient-themed UI for login and OTP screens
- ✅ Route protection and user session check
- 🧠 Modular code structure with `AuthService`
- 🏠 Navigation to `HomeScreen` after successful login

---

### 📦 Tech Stack

| Layer         | Tools Used                          |
|--------------|--------------------------------------|
| UI           | Flutter, Material Design             |
| Auth Backend | Firebase Authentication              |
| State Mgmt   | Stateful widgets (can upgrade later) |
| Packages     | `firebase_auth`, `google_sign_in`    |

---

### 🛠️ Setup Instructions

#### 1. Clone the repo

```bash
git clone https://github.com/yourusername/flutter_auth_app.git
cd flutter_auth_app
```

#### 2. Install dependencies

```bash
flutter pub get
```

#### 3. Configure Firebase

- Create a Firebase project
- Add Android app with correct package name
- Add SHA-1 and SHA-256 fingerprints
- Enable **Phone**, **Email/Password**, and **Google** sign-in
- Download `google-services.json` and place it in `android/app/`

#### 4. Run the app

```bash
flutter run
```

---

### 📂 Folder Structure

```
lib/
├── screens/
│   ├── login_screen.dart
│   ├── phone_input_screen.dart
│   ├── otp_screen.dart
│   └── home_screen.dart
├── services/
│   └── auth_service.dart
└── main.dart
```

---

### 🔐 Authentication Flow

1. **Phone Login** → Enter number → Receive OTP → Verify → Go to Home
2. **Google Login** → Sign in → Go to Home
3. **Email/Password Login** → Sign in → Go to Home
4. **Session Check** → Auto-redirect to Home if already signed in

