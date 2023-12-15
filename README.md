# Quiz

Welcome to the free Quiz application project, built using the clean architecture design pattern and Trivia Api as it's backend.

This project demonstrates the use of advanced topics such as Clean Architecture, Firebase integration, Bloc pattern for state management and Hive for local storage.

## Structure

The application follows the principles of Clean Architecture and is structured into three primary layers:

Data Layer: This layer includes the models, data sources (remote and local), and the repositories. It interacts with Trivia api for remote data and Hive for local data.

Domain Layer: This layer contains the core business logic (use cases) and entity definitions.

Presentation Layer: This is where the UI-related logic resides. It uses Bloc for state management.

The application has one main features/modules:

Trivia: Handles the creation, fetching, and management of trivia questions.

All modules follow the above-mentioned architectural layers and are organized accordingly within their respective directories.A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
