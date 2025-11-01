### 🌼 Flower REST App
A Flutter application that fetches flower species data from a public API and displays it with images, search functionality, and local update/delete actions. Built with modular architecture and REST integration.

---

### 🚀 Features

- ✅ Fetch butterfly species from GBIF occurrence API
- ✅ Display scientific name, rank, and image
- ✅ Pull-to-refresh functionality
- ✅ Real-time search by name
- ✅ Local update and delete actions
- ✅ Clean, modular folder structure

---

### 📦 Folder Structure

```
lib/
├── models/
│   └── butterfly.dart
├── services/
│   └── butterfly_service.dart
├── screens/
│   └── butterfly_screen.dart
└── main.dart
```

---

### 🔧 Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
```

Run:
```bash
flutter pub get
```

---

### 📡 API Used

- **GBIF Occurrence API**  
  Endpoint: `https://api.gbif.org/v1/occurrence/search?q=butterfly&mediaType=StillImage`

---

### 🖼️ Screenshot Preview

> Add screenshots of your app here once available.

---

### 🧠 How It Works

- On launch, the app fetches butterfly data from GBIF.
- Each butterfly is displayed in a card with image, name, and rank.
- Users can search by name, update info locally, or delete entries.
- Refreshing the list re-fetches from the API.

---

### 🛠️ Setup Instructions

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/butterfly_rest_app.git
   cd butterfly_rest_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

### 📌 To-Do / Future Enhancements

- [ ] Persist updates/deletes using local storage
- [ ] Add pagination or lazy loading
- [ ] Add favorites/bookmark feature
- [ ] Add multi-screen navigation (e.g., Product Manager)

