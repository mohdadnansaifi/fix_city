<div align="center">

<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
<img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
<img src="https://img.shields.io/badge/Google%20Maps-4285F4?style=for-the-badge&logo=googlemaps&logoColor=white" />
<img src="https://img.shields.io/badge/Cloudinary-3448C5?style=for-the-badge&logo=cloudinary&logoColor=white" />

# 📍 FixCity — Civic Issue Reporting App

**A Flutter mobile app that empowers citizens to report, track, and resolve civic issues in their city.**

[Features](#-features) · [Screenshots](#-screenshots) · [Tech Stack](#-tech-stack) · [Getting Started](#-getting-started) · [Project Structure](#-project-structure) · [Database Schema](#-database-schema)

---

</div>

## 📌 Overview

FixCity is a smart civic issue reporting platform built for citizens. It bridges the gap between residents and municipal authorities by enabling transparent, real-time complaint tracking.

Citizens face daily issues — potholes, garbage overflow, broken street lights, water logging, road damage — with no clear way to report them or know if action is being taken. FixCity solves this by giving every citizen a direct line to local authorities, with live status updates every step of the way.

> **Connected to:** [FixCity Admin Panel](../fix_city_admin_web) — the web dashboard used by municipal authorities to manage and resolve reported issues.

---

## ✨ Features

### 🔐 Authentication
- Email & password login / registration
- Google Sign-In (OAuth)
- Forgot password / reset via email
- Firebase Authentication with persistent session

### 👤 User Profile
- Name, email, phone, city, address
- Profile image upload (stored on Cloudinary)
- Edit profile at any time
- Data persisted in Firestore `users` collection

### 📋 Issue Reporting
- Capture or upload issue image
- Select issue category (Pothole, Garbage, Water Logging, Street Light, Road Damage, Other)
- Add a description
- Auto-fetch current location using device GPS
- Address resolved via Google Maps Geocoding API
- Report submitted to Firestore in real time

### 📁 My Reports
- View all submitted complaints
- See issue image, category, description, status, location, and timestamp
- Real-time status updates from admin actions

### 🔔 Notifications
- Push notification when admin changes status:
  - `Reported` → `In Progress`
  - `In Progress` → `Resolved`
- Notification history screen
- Notifications stored in Firestore `notifications` collection
- Unread badge count

### 🗺️ Location Tracking
- Google Maps integration
- Auto-detect current location on report creation
- Display report location on map in "My Reports"

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | Provider |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| Image Storage | Cloudinary |
| Maps & Location | Google Maps API, Geolocator |
| Notifications | Firestore + Firebase Cloud Messaging |
| Platform | Android, iOS |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / Xcode
- Firebase project configured
- Google Maps API key
- Cloudinary account

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/adnansaifi/fix_city.git
cd fix_city
```

**2. Install dependencies**

```bash
flutter pub get
```

**3. Configure Firebase**

- Create a project at [Firebase Console](https://console.firebase.google.com)
- Add Android and iOS apps to your Firebase project
- Download and place config files:
  - `google-services.json` → `android/app/`
  - `GoogleService-Info.plist` → `ios/Runner/`
- Enable **Authentication** (Email/Password + Google)
- Enable **Cloud Firestore**

**4. Add API keys**

Create `lib/core/constants/api_keys.dart`:

```dart
class ApiKeys {
  static const String googleMapsAndroid = 'YOUR_ANDROID_MAPS_KEY';
  static const String googleMapsIos = 'YOUR_IOS_MAPS_KEY';
  static const String cloudinaryCloudName = 'YOUR_CLOUD_NAME';
  static const String cloudinaryUploadPreset = 'YOUR_UPLOAD_PRESET';
}
```

Add your Maps key to `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="YOUR_ANDROID_MAPS_KEY"/>
```

**5. Run the app**

```bash
flutter run
```

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/          # App-wide constants, API keys
│   ├── theme/              # AppTheme, AppColors, AppTextStyles
│   └── utils/              # Date formatters, helpers
├── data/
│   ├── models/             # ReportModel, UserModel, NotificationModel
│   └── repositories/       # ReportRepository, UserRepository
├── features/
│   ├── auth/
│   │   ├── screens/        # LoginScreen, RegisterScreen, ForgotPasswordScreen
│   │   └── widgets/        # AuthTextField, SocialLoginButton
│   ├── home/
│   │   ├── screens/        # HomeScreen
│   │   └── widgets/        # HomeHeader, CreateReportButton
│   ├── report/
│   │   ├── screens/        # CreateReportScreen, MyReportsScreen
│   │   └── widgets/        # ReportCard, ImagePicker, LocationPicker
│   ├── notifications/
│   │   ├── screens/        # NotificationsScreen
│   │   └── widgets/        # NotificationCard
│   └── profile/
│       ├── screens/        # ProfileScreen, EditProfileScreen
│       └── widgets/        # ProfileAvatar, ProfileField
├── providers/
│   ├── auth_provider.dart
│   ├── report_provider.dart
│   └── notification_provider.dart
└── main.dart
```

---

## 🗄️ Database Schema

### `users` collection

```
users/{uid}
├── uid: String
├── name: String
├── email: String
├── phone: String
├── city: String
├── address: String
├── profileImage: String (Cloudinary URL)
├── fcmToken: String
└── createdAt: Timestamp
```

### `issue_reports` collection

```
issue_reports/{reportId}
├── reportId: String
├── userId: String
├── category: String
├── description: String
├── imageUrl: String (Cloudinary URL)
├── location: Map
│   ├── latitude: double
│   ├── longitude: double
│   └── address: String
├── status: String  // "reported" | "in progress" | "resolved"
└── timestamp: Timestamp
```

### `notifications` collection

```
notifications/{notificationId}
├── notificationId: String
├── userId: String
├── reportId: String
├── title: String
├── body: String
├── createdAt: Timestamp
└── isRead: Boolean
```

---

## 🔄 App Workflow

```
User registers / logs in
        ↓
Captures issue + location
        ↓
Image uploaded to Cloudinary
        ↓
Report saved to Firestore
        ↓
Admin receives report in real time (Admin Panel)
        ↓
Admin updates status
        ↓
Notification created in Firestore
        ↓
User receives push notification
        ↓
User views updated status in My Reports
```

---

## 🔥 Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Users: read/write own profile only
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }

    // Reports: user creates own, reads own; admin reads/updates all
    match /issue_reports/{reportId} {
      allow create: if request.auth != null
                    && request.resource.data.userId == request.auth.uid;
      allow read: if request.auth != null
                  && (resource.data.userId == request.auth.uid
                  || get(/databases/$(database)/documents/admin/$(request.auth.uid)).data.role == 'admin');
      allow update: if get(/databases/$(database)/documents/admin/$(request.auth.uid)).data.role == 'admin';
    }

    // Notifications: user reads own only
    match /notifications/{notificationId} {
      allow read: if request.auth.uid == resource.data.userId;
      allow write: if get(/databases/$(database)/documents/admin/$(request.auth.uid)).data.role == 'admin';
    }
  }
}
```

---

## 🌱 Future Improvements

- [ ] AI-based auto categorization from issue image
- [ ] Department-based routing (e.g. Water Dept, Roads Dept)
- [ ] Government portal integration
- [ ] Multilingual support (Hindi, Urdu, etc.)
- [ ] Reward/points system for active reporters
- [ ] AI prioritization for urgent complaints
- [ ] Offline report drafting with sync on reconnect

---

## 👨‍💻 Developer

**Adnan Saifi**
BCA Student · Flutter Developer

Built for real-world civic issue management.

---

<div align="center">

⭐ Star this repo if you found it useful!

</div>
