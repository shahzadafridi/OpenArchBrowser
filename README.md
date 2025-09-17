# OpenArchBrowser

An open-source browser project inspired by Arch Browser, built with Flutter.

## Overview

OpenArchBrowser is an **open-source browser project** built with **Flutter** as a cross-platform solution, targeting Desktop Window, Linux & MacOS. The project aims to provide a modern, efficient, and customizable browsing experience while maintaining high performance and security standards.

<img width="2792" height="1442" alt="screenshot_3x_postspark_2025-09-17_13-38-01" src="https://github.com/user-attachments/assets/e5f89cb3-ea08-4382-b982-9e2379b00bdc" />


## Architecture

The project follows **MVVM** adapted for Flutter, ensuring a clear separation of concerns:

- **Data Layer**
    - Repository Implementation
    - Local/Remote Data Sources
    - Database Management

- **Presentation Layer**
    - ViewModels / Providers
    - Widgets (Flutter UI)
    - Navigation (GoRouter)

## Tech Stack & Libraries

- **Core:** Flutter SDK, Dart
- **State Management:** Provider
- **Navigation:** GoRouter / AutoRoute
- **Database:** SQLite, SharedPreferences
- **Networking:** WebView integration

## Project Structure
```
lib/
 ├── app/
 ├── data/
 │   ├── local/
 │   └── repositories/
 ├── model/
 ├── resources/
 ├── presentation/
 │   ├── widgets/
 │   └── viewmodels/
 └── utils.dart
```

## Setup & Installation

1. **Requirements:**
    - Flutter SDK
    - Android Studio or VS Code
    - Git

2. **Clone the repository:**
    ```bash
    git clone https://github.com/shahzadafridi/OpenArchBrowser.git
    cd OpenArchBrowser
    ```
3. **Install dependencies:**
    ```bash
    flutter pub get
    ```
4. **Run the app:**
    ```bash
    flutter run
    ```

## Current Features
- Basic browser functionality
- Bookmark 
- Tabs
- Recent Searches 

## Planned Features
- Tab management
- History tracking
- Custom themes
- Ad blocking

## Contributing
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to your branch
5. Open a pull request

## Contact
GitHub: [@shahzadafridi](https://github.com/shahzadafridi)
