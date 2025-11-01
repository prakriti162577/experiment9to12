## 🧮 Flutter Calculator with SQLite

A lightweight and responsive calculator app built with **Flutter**, featuring advanced math operations and **local history storage using SQLite**. Perfect for offline use and learning how to integrate persistent local databases in mobile apps.

---

## 🚀 Features

- 🔢 Basic and scientific calculator operations (√, ^, log, sin, cos, tan)
- 📦 Local data storage using SQLite
- 📜 History screen to view stored calculations
- 📱 Responsive UI with grid-based layout
- 📁 Modular code structure for scalability

---

## 📦 Tech Stack

| Tool | Purpose |
|------|--------|
| Flutter | UI and app logic |
| math_expressions | Parsing and evaluating math expressions |
| sqflite | SQLite database integration |
| path_provider | Locating device storage for database file |

---

## 🔧 Setup Instructions

### 1. Clone the Repo
```bash
git clone https://github.com/your-username/flutter-sqlite-calculator.git
cd flutter-sqlite-calculator
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Add Required Packages to `pubspec.yaml`
```yaml
dependencies:
  flutter:
    sdk: flutter
  math_expressions: ^2.1.0
  sqflite: ^2.3.0
  path_provider: ^2.0.14
```

---

## 📁 Folder Structure

```
/lib
  ├── main.dart
  ├── calculator_home.dart
  ├── history_screen.dart
  ├── db/
  │   └── database_helper.dart
```

---

## 🗃️ SQLite Structure

Each calculation is stored in a local SQLite table:
```sql
CREATE TABLE history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  expression TEXT,
  result TEXT,
  timestamp TEXT
);
```

---

## 📱 Run the App

```bash
flutter run
```

---

## 🛠️ Next Steps

- Add deletion or filtering of history entries
- Add export to CSV or share history
- Add dark mode toggle
- Integrate Firebase later for cloud sync
