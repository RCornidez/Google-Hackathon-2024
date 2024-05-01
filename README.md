# Trees Bees & Seas

The environmental conservation application submission for the Google AI Hackathon 2024.

See on DevPost => https://devpost.com/software/trees-bees-and-seas

See presentation on YouTube => https://www.youtube.com/watch?v=TmlGwUXieh4

See the API for this application => https://github.com/RCornidez/Google-Hackathon-API-2024

<img src="app.gif" height="400" alt="GIF" style="width: auto;">

## Table of Contents
<ul>
    <li><a href="#how">How-to-run</a></li>
    <li><a href="#files">Folders and files relevant to the project</a></li>
</ul>

<h3 id="how"> How-to-run: </h3>

```
## Prerequisites:
1. Flutter and Git needs to be installed on your system.
2. You will need an emulator or connected Android device in order to display the application.
3. The API will need to be setup and running in order for you to use the application fully. Otherwise you will be stuck on the loading screen.
Link to the API => https://github.com/RCornidez/Google-Hackathon-API-2024

# Clone the git repository
git clone https://github.com/RCornidez/Google-Hackathon-2024.git

## Install the dependencies
flutter pub get

## Run the application
flutter run

```

<h3 id="files"> Folders and files relevant to the project: </h3>

```
/ Trees Bees & Seas Flutter Application
|-- android/app/src/main/res
|   |-- AndroidManifest.xaml        # Modify the application screen name using the android:label
|   |-- mipmap-*/
|   |   |--- ic_launcher.png        # The various icon sizes used for the application
|-- lib/
|   |-- main.dart                   # Initializes the fonts, logger & socket service
|   |-- pages/
|   |   |-- landing_page.dart       # Entry page where users upload files
|   |   |-- loading_page.dart       # Manages the file upload and progress monitoring
|   |   |-- results_page.dart       # Displays results and allows for PDF Environmental Report download
|   |-- services/
|   |   |-- logger_service.dart     # Handles logging across the application
|   |   |-- socket_service.dart     # Manages WebSocket connections
|-- assets/
|   |-- logo.png                    # Logo for landing screen
|   |-- loading.json                # Lottie animation for loading screen
|-- pubspec.yaml                    # Manage the application's dart packages

```

