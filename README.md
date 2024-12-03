# TwnSqr Mobile App

A Flutter application for managing and discovering local community activities.

## Project Overview

TwnSqr is a community platform connecting users with local activities, focusing on sports, wellness, and social events.

## Tech Stack

- Flutter 3.24.4
- GetX for state management
- flutter_svg: ^0.22.0
- intl: ^0.19.0
- flutter_animate: ^4.5.0

## Project Structure

```
lib/
├── controllers/
│   └── activity_controller.dart
├── models/
│   └── activity.dart
├── presentation/
│   ├── layouts/
│   │   ├── mobile_layout.dart
│   │   ├── tablet_layout.dart
│   │   └── desktop_layout.dart
│   └── widgets/
│       └── activity_card.dart
├── utils/
│   └── contrast/
│       └── image_strings.dart
└── main.dart
```

## Setup Instructions

1. Install Flutter 3.24.4
2. Clone repository:
```bash
git clone https://github.com/anshrajani7/twnsqr.git
```
3. Install dependencies:
```bash
flutter pub get
```
4. Run application:
```bash
flutter run
```

## Features

- Activity discovery and booking
- Timeline view of daily activities
- Category filtering
- Progress tracking
- Search functionality

## Repository

- Owner: Ansh Rajani
- URL: https://github.com/anshrajani7/twnsqr

## License

MIT License