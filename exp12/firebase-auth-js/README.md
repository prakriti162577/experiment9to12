
## Firebase Auth JS — Expo + Firebase Authentication App

A cross-platform React Native app built with **Expo**, featuring secure authentication using **Firebase**. Supports **email/password login**, **Google Sign-In**, and **password reset** — all wrapped in a clean, modular structure.

---

## 🚀 Features

- 🔐 Firebase Email/Password Login
- 🔑 Google Sign-In (Expo Go + Android)
- 🔁 Password Reset Flow
- 🧭 Navigation with React Navigation
- 📁 Modular folder structure (`components/`, `screens/`)
- ✅ Route redirection after login

---

## 📦 Tech Stack

| Tool | Purpose |
|------|--------|
| Expo | React Native development |
| Firebase | Authentication backend |
| React Navigation | Screen routing |
| expo-auth-session | Google Sign-In |
| react-native | UI components |

---

## 🔧 Setup Instructions

### 1. Clone the Repo
```bash
git clone https://github.com/your-username/firebase-auth-js.git
cd firebase-auth-js
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Configure Firebase
- Create a Firebase project at [firebase.google.com](https://firebase.google.com)
- Enable **Email/Password** and **Google** sign-in under **Authentication → Sign-in method**
- Add your Expo redirect URI:
  ```
  https://auth.expo.io/@prakr777/firebase-auth-js
  ```

### 4. Add Firebase Config
Create `firebaseConfig.js`:
```js
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';

const firebaseConfig = {
  apiKey: 'YOUR_API_KEY',
  authDomain: 'YOUR_PROJECT.firebaseapp.com',
  projectId: 'YOUR_PROJECT_ID',
  storageBucket: 'YOUR_PROJECT.appspot.com',
  messagingSenderId: 'YOUR_SENDER_ID',
  appId: 'YOUR_APP_ID',
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
```

---

## 📱 Run the App

```bash
npx expo start -c
```

Open in **Expo Go** or scan the QR code.

---

## 🧪 Testing Google Sign-In

Make sure you’ve added:
- ✅ `expoClientId` (Web client ID from Firebase)
- ✅ `androidClientId` (created in Google Cloud Console with Expo’s shared SHA-1)

---

## 📁 Folder Structure

```
/components
  └── GoogleSignIn.js
/screens
  ├── LoginScreen.js
  ├── SignupScreen.js
  ├── ForgotPasswordScreen.js
  └── HomeScreen.js
firebaseConfig.js
App.js
app.json
```

---

## 🛠️ Next Steps

- Add route protection for authenticated users
- Style login screen with gradients and icons
- Add phone number login with OTP
- Create user profile screen
