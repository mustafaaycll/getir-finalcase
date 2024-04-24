# Getir Final Case
![screenshots](../blob/main/showcase.png?raw=true)

## Description
This iOS app is a simplified version of the Getir shopping experience, designed as part of a bootcamp case study. It enables users to browse products, add them to a shopping cart, and manage their purchases. The app utilizes Swift UIKit programmatically and follows VIPER architecture pattern to ensure clean and maintainable code. Users can navigate through Product Listing, Product Detail, and Shopping Cart screens, leveraging a compositional layout for a dynamic and responsive UI. The project adheres to the design guidelines provided and includes custom views for an enhanced user experience. The app interacts with mock APIs to simulate a real-world application and is built to be compatible with Xcode 15.x, ensuring it is production-ready.

## Getting Started
1. Make sure you have the Xcode version 15.0 or above installed on your computer
2. Clone the repository
3. Dependencies are handled by SPM
4. Open the project and run the active scheme

You should see products listed on the screen

## Architecture
* Project is implemented using the VIPER architecture pattern as a collection of modules and components (custom views)
* Modules can be found under Modules directory, each has a:
  * View controller: responsible for the 
  * Interactor: responsible for reading, writing and providing data to presenter
  * Presenter: responsible for handling the logic behind the view controller 
  * Router: responsible for the creation of the module itself and routing to other modules 
* Components can be found under Components directory

## Structure
* "Shared": Files or resources that are shared across multiple parts of the project, such as modules and components
  * "Components": Custom views that are utilized by modules
  * "Entities": Models that are used by modules
  * "Utilities": Caching and networking services as well as shared bases by modules
  * "Configs": Configuration files holding constants, such as dimensions, texts, identifiers, paddings etc.
* "Resources": Directory storing the assets
* "Application": Directory storing the AppDelegate and SceneDelegate
* "Modules": Modules that define the core elements of a view

## Dependencies
[Swift Package Manager](https://www.swift.org/documentation/package-manager/) is used as a dependency manager. Here is the list of dependencies:
* [Moya](https://swiftpackageindex.com/Moya/Moya): Network abstraction layer written in Swift

## Note to Reviewers
Due to the being short on time and the lack of knowledge on programmatical Swift UIKit and VIPER architecture pattern at the beginning of the project; preparing a development roadmap and utilizing git properly were not possible. This is why the repository includes only few commits but no branch etc. at all.
