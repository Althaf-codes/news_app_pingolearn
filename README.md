# News App

This project was developed as a part of the task assigned for the Flutter developer role at PingoLearn. The app demonstrates several key features required for the role, along with some additional functionalities to enhance the user experience.

## Features

### Required Features
- **Firebase Authentication (Email only)**
  - User registration and login with email and password.
- **User Details Collection**
  - Collects user details (name, email) and stores them in Firestore under a `user` collection.
- **News Feed**
  - Displays top headlines in a country fetched from the News API (newsapi.org).
  - Country code is fetched from Firebase Remote Config.

### Additional Features
- **Forgot Password**
  - Allows users to reset their password via email.
- **Category-wise News Fetch**
  - Users can filter news by categories such as business, entertainment, general, health, science, sports, and technology.
- **Translation**
  - Provides translation of news titles and descriptions into multiple languages using Google Translator.
- **Search**
  - Implements a search feature with a debounce technique to minimize unnecessary API calls.
- **WebView**
  - Opens news articles in a WebView within the app.
- **Custom News Detail Screen**
  - Displays detailed news articles with a custom UI.
- **Architecture**
  - Uses MVVM (Model-View-ViewModel) architecture for better code management and testability.

## Getting Started

### Prerequisites
- Flutter SDK
- Firebase project with Firestore and Authentication set up
- News API key from newsapi.org

  ### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/news_app.git
   cd news_app
   
2. **Install dependencies**
   ```bash
   flutter pub get
3. **Set up Firebase**
-Add your google-services.json file for Android and GoogleService-Info.plist for iOS in the respective directories.
-Configure Firebase in your Flutter project. 

4.**Run the app**
  ```bash
  flutter run

