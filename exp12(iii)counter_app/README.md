# 🔐 Firebase Auth Counter App

A Flutter app that demonstrates Firebase Email/Password authentication with a personalized counter screen. Built with clean architecture, aesthetic UI, and modular code.

---

## 🚀 Features

- ✅ Firebase Email/Password login & registration
- ✅ Auth state routing with `StreamBuilder`
- ✅ Personalized counter screen with user email
- ✅ Logout functionality with route protection
- ✅ Error handling via SnackBars
- ✅ Aesthetic UI with deep purple theme

---

## 🛠️ Setup Instructions

### 1. Clone the repo
```bash
git clone https://github.com/your-username/counter_app.git
cd counter_app
```

### 2. Add Firebase config
- Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
- Enable **Email/Password** sign-in method
- Download `google-services.json` and place it in:
  ```
  android/app/google-services.json
  ```

### 3. Update dependencies
In `pubspec.yaml`:
```yaml
firebase_core: ^4.2.0
firebase_auth: ^6.1.1
```

Run:
```bash
flutter pub get
```

### 4. Set correct NDK version
In `android/app/build.gradle.kts`:
```kotlin
ndkVersion = "27.0.12077973"
```

---

## 📱 Screens

| Login Screen | Register Screen | Counter Screen |
|--------------|-----------------|----------------|
| Email & password login | Create account | Personalized counter with logout |

---

## 📦 Folder Structure

```
lib/
├── main.dart
├── services/
│   └── auth_service.dart
├── screens/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   └── counter_screen.dart
```

---

## ✅ How It Works

- `main.dart` uses `StreamBuilder` to route between login and counter screens
- `AuthService` wraps FirebaseAuth methods
- UI is styled with rounded fields, icons, and deep purple accents
- Logout triggers `signOut()` and redirects to login

---

## 🧪 Test Checklist

- [x] Register new user
- [x] Login with email/password
- [x] View counter screen with email
- [x] Tap logout → return to login
- [x] Error messages shown via SnackBar

---

## 🌸 Optional Enhancements

- Google Sign-In or Phone OTP
- Splash screen with flower theme
- Profile screen with avatar
- Password reset flow