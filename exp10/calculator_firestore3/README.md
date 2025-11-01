## 🧮 Flutter Calculator with Firebase Firestore

A clean and responsive calculator app built with **Flutter**, featuring advanced math operations and **Firebase Firestore integration** to store and view calculation history. Ideal for learning how to combine UI logic with cloud-based data persistence.

---

## 🚀 Features

- 🔢 Basic and scientific calculator operations (√, ^, log, sin, cos, tan)
- 🔐 Firebase initialization and Firestore setup
- 📤 Saves each calculation to Firestore with timestamp
- 📜 History screen to view stored calculations in real-time
- 📱 Responsive UI with grid-based layout

---

## 📦 Tech Stack

| Tool | Purpose |
|------|--------|
| Flutter | UI and app logic |
| math_expressions | Parsing and evaluating math expressions |
| Firebase Core | Firebase initialization |
| Cloud Firestore | Storing and retrieving calculation history |

---

## 🔧 Setup Instructions

### 1. Clone the Repo
```bash
git clone https://github.com/your-username/flutter-firebase-calculator.git
cd flutter-firebase-calculator
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Firebase
- Create a Firebase project at [firebase.google.com](https://firebase.google.com)
- Enable **Firestore Database** in test mode
- Download `google-services.json` for Android and place it in:
  ```
  android/app/google-services.json
  ```
- Add Firebase initialization to `main.dart`:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CalculatorApp());
}
```

---

## 📁 Folder Structure

```
/lib
  ├── main.dart
  ├── calculator_home.dart (optional split)
  ├── history_screen.dart (optional split)
```

---

## 🧪 Firestore Structure

Each calculation is stored in the `history` collection:
```json
{
  "expression": "2+2",
  "result": "4",
  "timestamp": "2025-11-01T16:00:00Z"
}
```

---

## 📱 Run the App

```bash
flutter run
```

---

## 🛠️ Next Steps

- Add Firebase Authentication for user-specific history
- Enable deletion or filtering of history entries
- Add dark mode toggle
- Export history to PDF or CSV
