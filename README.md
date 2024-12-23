# Gamified Authenticator App Prototype

## Overview

MFA Gamification App is a Flutter-based mobile application that transforms the authentication process into an engaging and rewarding experience. It utilizes Firebase Cloud Messaging (FCM) to send authentication requests to the user. The app includes a verification and secret code input system, and users earn points for successful authentication attempts, leveling up as they progress.

---

## Features

- **Firebase Integration**: 
  - Uses Firebase for messaging.
- **Gamified Authentication**:
  - Earn points and level up by completing authentication challenges.
  - Get new customizations while increasing a number of connected services.
- **Request Verification**:
  - Users validate requests using a verification code sent via Firebase messages.
- **Dynamic UI**:
  - User-friendly interface with progress tracking and motivational feedback.

---

## How It Works

1. **Firebase Messaging**: 
   - The app listens for authentication requests from Firebase.
2. **Verification Code**:
   - Users are prompted to enter the verification code sent in the request.
   - If the verification code is correct, the app transitions to the secret code input screen.
   - Points are awarded for successful verification.
3. **Secret Code**:
   - Users input their secret code to complete the authentication.
   - Points are awarded for successful authentication.
4. **Gamification**:
   - Users level up once they reach a points threshold.
   - Leveling up users achieve simpler options to verify requests.
   - Connecting services users unlock customizations.
   - Users get feedback and reward messages.

---

## Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
2. Navigate to the project directory:
   ```bash
   cd mfa_gamification
   ```
3. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
4. Configure Firebase:
   - Follow the instructions in the [Firebase Console](https://console.firebase.google.com/) to set up Firebase for your app.
   - Replace the `google-services.json` and `GoogleService-Info.plist` files in your project.

5. Run the app:
   ```bash
   flutter run
   ```

---

## Screens

### 1. Home Screen
- Displays the user's current points and level.
- Tracks progress toward the next level.

### 2. Verification Screen
- Shows request details and prompts the user to input a verification code.
- On lower levels and when user is doing last authentication before leveling up, they need to input verification code themselves.
- On mid-levels users can choose a correct code out of many.
- On higher levels users see the code on the screen and click 'Verify' to verfiy.

### 3. Code Input Screen
- Users input their secret code to complete the authentication.
- Users can input their secret code using colourful bubbles when they unlock this feature.

### 4. Settings Screen
- Displays customization options and features switches.

---

## Gamification Logic

- **Points**: Earn 10 points for each successful verification and 5 points for authentication.
- **Level Up**: Reach 50 points to move to the next level.
- **Progress Indicator**: A progress bar tracks the points toward the next level.

---

## Technologies Used

- **Flutter**: Frontend framework for cross-platform development.
- **Firebase**: Cloud messaging for receiving push notifications.

---

## License
This project is proprietary. All rights are reserved. For inquiries, contact [github.com/Jesya-o](https://github.com/Jesya-o).

---

## Contact

For questions or suggestions, feel free to reach out:
- **GitHub**: [github.com/Jesya-o](https://github.com/Jesya-o)

---
