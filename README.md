# BellyLog

BellyLog is a personal gut-health tracking app built with Flutter. It helps users record meals, symptoms, bowel movements, and daily lifestyle check-ins, then uses AI to generate a weekly review of possible patterns between food, gut symptoms, and day-to-day factors.

The goal is to make personal tracking practical and help users notice patterns in their own logs—not to diagnose conditions or establish that a food caused a symptom.

## Features

- **Meal logging:** Record meal type (breakfast, lunch, dinner, or snack), foods eaten, and the automatically captured time.
- **Symptom logging:** Record gut-related symptoms with a timestamp and a free-text description.
- **Bowel movement logging:** Record bowel movements using the 1–7 Bristol Stool Scale and an automatically captured time.
- **Daily check-ins:** Track a daily stress rating (1–5) and hours of sleep.
- **Dashboard:** Review saved entries across the four logging categories.
- **Weekly AI analysis:** Generate a weekly summary highlighting possible correlations and recurring patterns across meals, symptoms, bowel movements, and check-ins.

> **Health note:** BellyLog is a tracking and reflection tool, not a medical device or a substitute for professional medical advice. AI-generated observations are exploratory and may be incomplete or inaccurate. Correlation does not establish causation; discuss health concerns or decisions with a qualified healthcare professional.

## Tech Stack

- **Flutter / Dart** — application framework and language
- **Hive / Hive Flutter** — local data storage
- **HTTP** — network requests for AI analysis
- **flutter_dotenv / dotenv** — environment configuration
- **intl, timezone, flutter_timezone** — date, time, and timezone utilities
- **dynamic_color, cupertino_icons** — UI and platform styling
- **flutter_slidable** — swipe actions
- **flutter_local_notifications** — local notifications
- **lottie** — animations
- **share_plus, path_provider** — sharing and file-system access

## Requirements

Install the Flutter SDK and a compatible Dart SDK. The project declares:

- Dart SDK constraint: `^3.12.2`
- Flutter SDK: required

Also configure an emulator, simulator, or physical device for your target platform. See the [official Flutter installation guide](https://docs.flutter.dev/get-started/install).

## Getting Started

### 1. Clone the repository

```bash
git clone <REPOSITORY_URL>
cd bellylog
```

Replace `<REPOSITORY_URL>` with the URL of your GitHub repository.

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure environment variables

BellyLog includes a `.env` asset for configuration. Create a `.env` file in the project root and add the environment variables required by the AI analysis integration.

For example:

```dotenv
# Add the variable names and values required by your configured AI service.
```

Do not commit API keys or other secrets. Keep `.env` out of version control, and provide a safe example file such as `.env.example` if you want to document the required variable names.

### 4. Run the app

Check that Flutter can see your target device:

```bash
flutter devices
```

Run the application:

```bash
flutter run
```

To target a specific device, use the device ID shown by `flutter devices`:

```bash
flutter run -d <DEVICE_ID>
```

## Useful Development Commands

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Generate launcher icons:

```bash
dart run flutter_launcher_icons
```

If the project uses Hive adapters generated with `hive_generator`, regenerate them with:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Building

Build an Android APK:

```bash
flutter build apk
```

Build an Android App Bundle:

```bash
flutter build appbundle
```

Build for iOS (requires macOS and Xcode):

```bash
flutter build ios
```

## Project Configuration

The app's package configuration, dependency versions, asset directories, and SDK constraint are defined in `pubspec.yaml`.

Assets are configured under:

- `assets/`
- `assets/icons/`
- `assets/lotties/`
- `.env`

## Privacy and Data

BellyLog records personal health-related information. Review storage, backup, sharing, and AI-service behavior before using it with sensitive data. Only send information to an external AI service when the user has knowingly configured and enabled that integration.

## Project Status

**Version:** `1.0.0+1`

The core logging experience, dashboard views, and weekly AI-generated analysis are implemented.

## License

No license has been specified yet. Unless a license is added to this repository, all rights remain with the copyright holder and reuse is not automatically granted.
