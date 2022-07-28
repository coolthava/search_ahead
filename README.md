# search_ahead

A new Flutter project.

## Getting Started

1) Please run [flutter pub get] in root directory, followed by [flutter pub run build_runner build --delete-conflicting-outputs]

2) Choose desired mobile emulator or macos and then click run.

# Descriptions

State Management: flutter_bloc and get_it

Architecture: MVVM-C

Navigation: auto_route (using Navigator 2.0)

Features:

    Home -> To allow user to search for events

    Details -> To show users event details and favourite them

All optional features completed.

# Notes for some future improvements:

1. Create pagination for eventList (currently getting 25 items only)
2. Use caching for apis
3. Add networkUtils to check internet connection before performing api call in repo
4. More error checking in terms of empty models
5. Create deeplink Handling
6. Widget Testing
7. Move Strings into a localisation file or create constants
8. Create constant file for Colors

