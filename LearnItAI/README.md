# LearnIt AI

A modern SwiftUI-based learning app that helps users study with AI-powered features.

## Features

### 🏠 Home Tab
- **Create Flashcards**: Manual flashcard creation
- **Generate AI Flashcards**: AI-powered flashcard generation
- **Create Practice Questions**: Manual practice question creation
- **Generate AI Practice Questions**: AI-powered practice questions
- **Generate AI Practice Test**: AI-powered comprehensive tests
- **Scan Problem**: Camera-based problem scanning

### ✅ Tasks Tab
- **AI Token System**: Track and manage AI usage tokens
- **Daily Tasks**: Complete tasks to earn tokens
- **Invite Friends**: Earn tokens by inviting friends
- **Premium Subscription**: Upgrade for unlimited features

### 📚 Your Library Tab
- **Content Organization**: Store all flashcards, practice questions, and tests
- **Search Functionality**: Find content quickly
- **Filter System**: Filter by content type
- **Progress Tracking**: See last studied dates and item counts

## Project Structure

```
LearnItAI/
├── LearnItAI.xcodeproj/           # Xcode project file
└── LearnItAI/                     # Main app folder
    ├── LearnItAIApp.swift         # App entry point
    ├── ContentView.swift          # Main tab view container
    ├── HomeView.swift             # Home screen with feature grid
    ├── TasksView.swift            # Tasks and token management
    ├── LibraryView.swift          # Library and content organization
    ├── Assets.xcassets/           # App assets and icons
    └── Preview Content/           # SwiftUI preview assets
```

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started

1. Open `LearnItAI.xcodeproj` in Xcode
2. Select your target device or simulator
3. Press `Cmd + R` to build and run

## UI Design Highlights

- **Modern SwiftUI Interface**: Clean, intuitive design
- **Gradient Cards**: Beautiful feature cards with shadows
- **Token System**: Gamified learning with reward tokens
- **Responsive Layout**: Works on iPhone and iPad
- **Dark/Light Mode Support**: Automatic theme switching

## Next Steps

To extend this app, consider implementing:

1. **Core Data Integration**: Persistent storage for user content
2. **AI Integration**: Connect with OpenAI or other AI services
3. **Camera Functionality**: Implement problem scanning
4. **User Authentication**: User accounts and cloud sync
5. **In-App Purchases**: Premium subscription implementation
6. **Push Notifications**: Study reminders and achievements

## License

This project is created for educational purposes.