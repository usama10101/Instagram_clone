# Instagram Clone App

A Flutter project replicating some functionalities of Instagram, utilizing Firebase for backend services.

## **Features**
- User Authentication (Sign Up, Sign In, and Forgot Password) using Firebase Authentication
- Real-time chat functionality
- Image uploading and fetching with Firebase Storage
- Following and unfollowing users
- Posting images and viewing user feeds
- Profile management and settings

## **Project Structure**
```plaintext
lib/
├── models/        # Data models for the app
├── pages/         # UI screens for authentication, home, profile, etc.
├── bloc/          # Business logic layer using Cubit/BLoC architecture
├── services/     # Firebase services and API calls
├── widgets/     # Reusable custom widgets
└── main.dart     # App entry point
```

## **Installation and Setup**
1. **Clone the repository:**
   ```bash
   git clone https://github.com/YourUsername/instagram_clone.git
   cd instagram_clone
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase:**
   - Go to [Firebase Console](https://console.firebase.google.com/).
   - Create a new project and register your app.
   - Download the `google-services.json` for Android and `GoogleService-Info.plist` for iOS.
   - Place them in the appropriate directories (`android/app` and `ios/Runner`).

4. **Run the app:**
   ```bash
   flutter run
   ```

## **Technologies Used**
- **Flutter**: Cross-platform development
- **Firebase**: Backend as a service (Authentication, Firestore, Storage)
- **Cubit (Bloc)**: State management
- **Shared Preferences**: Local storage
- **Device Info Plus**: Device identification

## **Key Commands**
| Command | Description |
|---------|-------------|
| `flutter pub get` | Install dependencies |
| `flutter run` | Run the app locally |
| `flutter build apk` | Build APK for Android |

## **Contributing**
1. Fork the project.
2. Create your feature branch: `git checkout -b feature/AmazingFeature`.
3. Commit your changes: `git commit -m 'Add some AmazingFeature'`.
4. Push to the branch: `git push origin feature/AmazingFeature`.
5. Open a pull request.

## **License**
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## **Contact**
Developed by **Osama Mohamed**. Feel free to reach out on [LinkedIn](www.linkedin.com/in/osama-mohammed-b84032255) or through GitHub.

