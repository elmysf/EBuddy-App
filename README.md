# E-Buddy

## Overview

This project is developed using SwiftUI, leveraging the MVVM (Model-View-ViewModel) architecture along with Combine for reactive programming.

<img src="https://github.com/elmysf/EBuddy-App/blob/main/Ebuddy-recording.GIF" width="300" />

## Table of Contents
- [Installation](#installation)
- [Setup Instructions](#setup-instructions)
- [Architecture](#architecture)

## Installation
To try out the Video Gallery app examples:
1. Clone the repo `https://github.com/elmysf/EBuddy-App.git`.
2. Open `EBuddy App.xcodeproj`.
3. Run `EBuddy App.xcodeproj` - framework is imported as a SPM package.
4. Try it!

## Architecture

The project follows the MVVM architecture, which separates the user interface from the business logic. Here's a brief breakdown:

- **Model:** Represents the data and business logic. It fetches data from Firebases or databases and manages data operations.
- **View:** Composed of SwiftUI views that define the user interface. It observes the ViewModel for data updates and user interactions.
- **ViewModel:** Acts as a bridge between the Model and the View. It holds the business logic, prepares data for display, and handles user input.
- **Combine:** Used for handling asynchronous data streams and updates. It allows for a reactive approach, updating the UI in response to data changes.

## Assumptions

- The project assumes a basic understanding of SwiftUI, Combine, and the MVVM architecture.
- Users are expected to have Xcode installed and set up on their machines to build and run the project.

## ScreenShoot
<img src="https://github.com/elmysf/EBuddy-App/blob/main/EBuddy-Screenshoot.png" width="800" />
