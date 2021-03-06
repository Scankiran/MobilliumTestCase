
  
# Mobillium Test Case

This app created for Mobillium Test Case task. In this application users can check up coming and playing now movies and check movies detail informations.

## Architecture
* When developing the app, I choose MVVM architecture because there are two screens at all, and a kinda small application. MVVM played an important role in making the code simpler. If VIPER was used instead of MVVM, some complexity and crowding could occur in the code.

* For image cache mechanism, Kingfisher pod used.

* I added a custom Gesture Handler to handle tap, double-tap, swipe left and swipe right. 

* I added custom Constants class to fetch strings and other constant properties. 

* I preferred XiB to create views and used auto layout. If there will be a complicated view, I will be preferred SnapKit or classical programmatic view.

* I added a custom `BaseTableViewCell` and custom extension methods to TableView to make easier register cells and use cells on table view delegate function.

* I added a custom `BaseCollectionViewCell` and custom extension methods to TableView to make easier register cells and use cells on table view delegate function.

* Checked memory leaks, no issue.

* Tested on iPhone 12 Mini - iOS 15.4

## Installation
If you want to clone and build project, you has to `pod install`.

## Screens

 There are two screen. Main View, Detail View. Let's check these out;


### Main View
On Main View, first checks the internet connection. If there is no connection, an alert show to user. 'Okey' button on alert check internet connection again and again if clicked. 

Movies fetched from API. There are two type of movie data which is up coming and playing now. Playing Now movies showed on slider which on top of the screen. Up Coming movies showed on cell which bottom of the slider.

After fetching, if there is an error, ProgressHud shows an alert with error description. If result return successfully, movie data shows on Main View. 

### Movie Detail View
On Detail View, users can see details of movie with bigger poster image.

