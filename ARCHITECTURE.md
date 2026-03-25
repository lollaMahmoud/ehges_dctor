# Clean Architecture Structure - احجز دكتورك

## Project Structure

```
lib/
├── core/                           # Core business logic and utilities
│   ├── constants/                  # App constants
│   │   ├── app_colors.dart        # Color constants
│   │   └── app_strings.dart       # String constants (text)
│   └── theme/
│       └── app_theme.dart         # Theme configuration
│
├── presentation/                   # UI Layer
│   ├── screens/                    # Screen implementations
│   │   ├── splash/                # Splash screen
│   │   ├── onboarding/            # Onboarding screens
│   │   └── auth/                  # Authentication screens (login, register)
│   └── widgets/                    # Reusable UI components
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       └── index.dart             # Widgets exports
│
└── main.dart                       # App entry point
```

## Architecture Overview

### Clean Architecture Layers:

1. **Presentation Layer** (`presentation/`)
   - Contains all UI screens and widgets
   - Handles user interactions
   - No business logic here
   - Uses state management (can be added later)

2. **Core Layer** (`core/`)
   - Constants (colors, strings)
   - Theme configuration
   - Utilities and helpers (to be added)

3. **Domain & Data Layers** (to be added as project grows)
   - Business logic
   - Repository patterns
   - API integration

## Navigation Flow

```
Splash Screen (3 seconds)
    ↓
Onboarding Screens (3 pages)
    ↓
Login Screen
    ↓
Register Screen (optional)
```

## Routes

- `/splash` - Splash screen
- `/onboarding` - Onboarding screens
- `/login` - Login screen
- `/register` - Registration screen

## Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Methods**: `camelCase`
- **Constants**: `CONSTANT_CASE` (for app-wide constants)

## Color Palette

- Primary Color: `#0099FF` (Blue)
- Primary Dark: `#0077CC`
- Teal: `#4A9B8E` (For secondaries)
- Text: Shades of gray/dark

## RTL Support

The app is configured for RTL (Right-to-Left) Arabic support:
- `locale: const Locale('ar')`
- All screens use `TextDirection.rtl` for Arabic text
- Responsive layouts that adapt to RTL

## How to Add New Screens

1. Create a new folder in `presentation/screens/`
2. Create the screen file: `your_screen_name_screen.dart`
3. Add the route in `main.dart`
4. Import and navigate to the new screen

Example:
```dart
routes: {
  '/your-route': (context) => const YourScreen(),
}
```

Then navigate with:
```dart
Navigator.of(context).pushNamed('/your-route');
```

## How to Add New Widgets

1. Create a new file in `presentation/widgets/`
2. Export it in `widgets/index.dart`
3. Use it across screens

## Getting Started

To run the app:
```bash
flutter pub get
flutter run
```

The app will start with the splash screen and navigate through the onboarding flow.
