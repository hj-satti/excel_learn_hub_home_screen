# **Excel LearnHub - Home Screen Task**

This repository contains the **Home Screen** implementation for the **Excel LearnHub** Flutter project.

## **Task Overview**

The goal of this task was to design and implement the **Home Screen** for the **Excel LearnHub** app. The Home Screen includes:

- **Welcome message** with the user's name (e.g., "Welcome, [User's Name]!").
- **Search bar** for searching available courses, with **voice search** functionality.
- **Course listing** that displays the available courses, each with progress tracking.
- **Category filter** to filter courses based on categories like "Mobile Development," "Programming Languages," etc.
- **Bottom navigation bar** to switch between the Home Screen and Profile Screen.

## **Project Structure**

- **`lib/screens/home_screen.dart`**: Main Home Screen widget that includes the search bar, course listing, and bottom navigation.
- **`lib/screens/course_detail_screen.dart`**: Screen that shows detailed information about each course (navigated to from the Home Screen).
- **`lib/screens/profile_screen.dart`**: Profile screen accessible from the bottom navigation bar.
- **`lib/widgets/course_card.dart`**: Widget that represents an individual course card shown on the Home Screen.
- **`lib/data/dummy_courses.dart`**: Sample course data used to populate the Home Screen's course listing.
- **`lib/main.dart`**: Main entry point that sets up the app and navigates to the Home Screen.

## **Getting Started**

To run the app locally, follow these steps:

1. **Clone this repository**:

    ```bash
    git clone https://github.com/your-username/excel_learn_hub.git
    ```

2. **Navigate to the project directory**:

    ```bash
    cd excel_learn_hub
    ```

3. **Install dependencies**:

    ```bash
    flutter pub get
    ```

4. **Run the app**:

    ```bash
    flutter run
    ```

## **Features**

- **Search Functionality**: Users can search for courses by name.
- **Voice Search**: Users can initiate a voice search to find courses.
- **Course Progress**: Each course card shows the completion percentage.
- **Category Filter**: Filter courses by categories (e.g., Mobile Development, Backend, etc.).
- **Bottom Navigation**: Switch between the Home Screen and Profile Screen.

## **Resources**

- [Flutter Documentation](https://flutter.dev/docs)  
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)  
- [Flutter Get Started](https://flutter.dev/docs/get-started)