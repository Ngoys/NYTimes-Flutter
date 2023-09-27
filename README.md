# New York Times API integration, Flutter<br />by [Shawn Ngo Yen Sern](https://www.linkedin.com/in/ngo-yensern/?originalSubdomain=my)

<img width="260" alt="img_1" src="https://github.com/Ngoys/NYTimes-Flutter/assets/6831096/7230f349-6d60-4056-97da-f33cfd24a515">
<img width="260" alt="img_3" src="https://github.com/Ngoys/NYTimes-Flutter/assets/6831096/50739dca-c635-4306-916b-556ed3efacea">
<img width="260" alt="img_2" src="https://github.com/Ngoys/NYTimes-Flutter/assets/6831096/00d6c270-5a2e-445e-a84a-0da452655e26">

## Installation

1. Clone the repo 
2. Open the project folder with `Visual Studio Code`
3. You should be on `main` branch
4. Open a terminal, enter `flutter pub get`
5. Enter `flutter pub run build_runner build --delete-conflicting-outputs` 
6. Enter `flutter run` to run the app in iOS or Android 

## Feature 

This project has **Flutter Bloc Cubit** code architecture to integrate [New York Times API](https://developer.nytimes.com/apis).<br />
It contains search pagination, unit test and a good code template to be utilize across all modules, allowing simple understanding and standardization. <br />

1. Pagination search feature
2. App architecture from CoreApp MultiBlocProvider, to AppOverlay, to AppContainer, to the HomeScreen UI 
3. Bloc-based UI building with Cubit state
4. GetIt dependency injection
5. Drift to store offline data
6. Unit testing  with Mockito on cubits
