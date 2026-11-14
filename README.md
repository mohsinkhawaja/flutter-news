# Flutter News Reader

A Flutter news-reader client that fetches headlines and category results from NewsAPI.

## What is included

- Browse publisher headlines and categories
- View article details and images
- Loading/error handling for external API requests

## Requirements

- Flutter SDK (Dart 3); start with Flutter **3.44.0** for this source revision. See the [official install guide](https://docs.flutter.dev/install).
- Git, or download this repository through **Code > Download ZIP** and extract it.
- A configured Android device/emulator; Chrome is also available for a web preview.
- Android builds require the Android SDK and a compatible JDK. iOS builds require macOS and Xcode.

## Download and run

```sh
git clone https://github.com/mohsinkhawaja/flutter-news.git
cd flutter-news
flutter doctor
flutter pub get
flutter devices
flutter run
```

`flutter run` prompts for an available target. To select one explicitly, use `flutter run -d <device-id>` with the ID printed by `flutter devices`.

For a browser preview: `flutter run -d chrome`. Native plugins may have platform-specific limitations.

## Code map

lib/repository/news_repository.dart performs HTTP requests; lib/models/ parses responses; lib/view_model/ connects data to the screens in lib/View/.

`pubspec.yaml` declares dependencies and assets. Keep `pubspec.lock` when reproducing an app checkout; generated files under `.dart_tool/` and `build/` should not be committed.

## Configuration and current scope

Requires your own NewsAPI development key. Do not use or rely on another contributor's key. The provider controls availability, rate limits and permitted use. See the API configuration below.

## API configuration

Obtain a development key from [NewsAPI](https://newsapi.org/docs/get-started), then run:

```sh
flutter run --dart-define=NEWS_API_KEY=YOUR_OWN_DEVELOPMENT_KEY
```

Or add `-d chrome` if your account permits browser requests. Missing keys and HTTP errors produce an explicit error. Build-time values are visible in a distributed client; use a controlled server proxy for a production secret rather than shipping it in a public web/mobile bundle. A previously committed development key must be revoked/rotated in its provider account; removing it from this revision does not erase Git history.

## Checks and builds

```sh
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
flutter build apk --debug
```

The analysis flags leave existing style warnings visible while still failing on errors. Debug APKs are for development; publishing requires your own release signing and target-platform setup. An Android/iOS build is not implied by passing Dart analysis.

## Troubleshooting

- On Windows, Flutter plugins need symlink support. If `flutter pub get` requests Developer Mode, follow Flutter's platform setup on your own machine; do not edit project code to bypass it.
- Run commands in the folder containing this app's `pubspec.yaml`.
- If a dependency fails to resolve, use the documented Flutter version and read the solver's message before upgrading packages.
- Check `flutter doctor` for missing platform tooling. A source checkout does not include the Android SDK, Xcode or release credentials.

## Project status

Source and setup were reviewed in November 2026. See the included scope notes before treating this learning project as a production application. No paid service, hosted API availability or production readiness is promised.

Install the Flutter SDK in a path without spaces (for example `C:/dev/flutter`) to avoid Windows native-asset hook issues. Your project folder can remain separate from the SDK.
