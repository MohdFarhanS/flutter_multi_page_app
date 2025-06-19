# multi_page_app

A multi-page Flutter application demonstrating user authentication (login, registration, forgot password), a home page displaying a list of items, and a user profile management section (edit profile, change password).

## Features

* **User Authentication**:
    * **Login**: Users can log in with a username and password.
    * **Registration**: New users can create an account with a username, email, and password. Includes password confirmation.
    * **Forgot Password**: Users can reset their password to a default value by providing their username.
* **Home Page**: Displays a list of items with their names, descriptions, and prices.
* **Detail Page**: Shows detailed information about a selected item, including its image, name, description, and price, with an "Add to Cart" button.
* **User Profile**:
    * **View Profile**: Displays the logged-in user's username and email.
    * **Edit Profile**: Allows users to update their username and email.
    * **Change Password**: Enables users to change their password by providing the old and new passwords.
* **Navigation**: Implements a `MainWrapper` with a `BottomNavigationBar` for easy navigation between the Home and Profile sections.
* **Persistent User Session**: Utilizes `shared_preferences` to maintain login status and user data across app launches.
* **Custom Widgets**: Reusable `CustomButton` and `CustomTextField` widgets for consistent UI.
* **Theming**: Custom color palette and text styles defined for a cohesive look and feel.

## Project Structure

The project follows a standard Flutter application structure:

lib/
├── main.dart                 # Main entry point of the application.
├── models/
│   └── item.dart             # Data model for items.
├── pages/
│   ├── auth/                 # Authentication related pages (Login, Register, Forgot Password).
│   │   ├── forgot_password_page.dart
│   │   ├── login_page.dart
│   │   └── register_page.dart
│   ├── detail/               # Item detail page.
│   │   └── detail_page.dart
│   ├── home/                 # Home page displaying items.
│   │   └── home_page.dart
│   ├── main_wrapper.dart     # Handles bottom navigation and wraps main content.
│   └── profile/              # User profile related pages.
│       ├── change_password_page.dart
│       ├── edit_profile_page.dart
│       └── profile_page.dart
├── services/
│   └── auth_service.dart     # Handles user authentication logic (login, register, logout, profile updates).
└── utils/
│   ├── app_colors.dart       # Defines the application's color palette.
│   └── app_styles.dart       # Defines custom text styles using Google Fonts.
└── widgets/
├── custom_button.dart    # Reusable button widget.
├── custom_text_field.dart# Reusable text input field widget.
└── item_card.dart        # Widget to display an individual item in the home list.

## Getting Started

This project is a starting point for a Flutter application.

To get a local copy up and running, follow these simple steps.

### Prerequisites

* Flutter SDK installed.
* Dart SDK installed.
* A code editor like VS Code or Android Studio with Flutter and Dart plugins.

### Installation

1.  Clone the repository:
    ```bash
    git clone [https://github.com/mohdfarhans/flutter_multi_page_app.git](https://github.com/mohdfarhans/flutter_multi_page_app.git)
    cd flutter_multi_page_app
    ```
2.  Get Flutter packages:
    ```bash
    flutter pub get
    ```
3.  Run the application:
    ```bash
    flutter run
    ```

### Initial Credentials (for testing)

Since the `AuthService` currently simulates authentication using `shared_preferences`, there are no predefined users initially. You will need to register a new account through the "Register Now" option on the login page.

* **Default Password for Reset**: If you use the "Forgot Password" feature, the password for the given username will be reset to `123456`.

## Resources

For help getting started with Flutter development, view the online documentation, which offers tutorials, samples, guidance on mobile development, and a full API reference.

* [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
* [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
* [Flutter online documentation](https://docs.flutter.dev/)

---