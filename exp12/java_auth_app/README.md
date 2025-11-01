
## 📄 `README.md` — Random Number Generator App with Firebase Auth

```markdown
# 🎲 Random Number Generator App with Firebase Authentication

An Android app that generates random numbers within a user-defined range — now secured with Firebase Authentication. Users must sign in to access the generator, making it ideal for personalized experiences, student demos, or secure classroom tools.

---

## 🚀 Features

- 🔐 Firebase Email/Password Authentication
- 🎲 Random number generation between any two integers
- 📱 Clean UI with input validation
- 🔁 Password reset and registration screens
- 🔒 Route protection for authenticated users only

---

## 📱 Screenshots

*(Add screenshots of login, register, and generator screens here)*

---

## 🛠️ Tech Stack

| Layer        | Technology                     |
|--------------|--------------------------------|
| Language     | Java                           |
| Platform     | Android                        |
| Auth         | Firebase Authentication        |
| UI           | ViewBinding                    |
| Min SDK      | 24                             |
| Target SDK   | 36                             |
| IDE          | Android Studio                 |

---

## 📦 Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/random-number-auth-app.git
   ```

2. Open in Android Studio

3. Add your `google-services.json` to the `app/` folder

4. Sync Gradle and run the app

---

## 🔐 Firebase Setup

- Enable **Email/Password** sign-in in Firebase Console
- Add your Android app with correct package name
- Download and place `google-services.json` in `app/`
- Confirm Firebase plugin is applied via Version Catalog

---

## 🧪 Usage

1. Launch the app
2. Register or log in with email/password
3. Enter min and max values
4. Tap **Generate**
5. View the result instantly

---

## 🧰 Customization

- Change theme in `res/values/themes.xml`
- Modify layout in `res/layout/activity_main.xml`
- Add Google Sign-In or Phone OTP via Firebase

---

## 🐞 Troubleshooting

- App crashes? Check Firebase initialization and `google-services.json`
- Auth errors? Confirm Firebase Console settings
- Gradle issues? Sync and rebuild the project

