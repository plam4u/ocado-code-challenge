#  README

## Requirements

- Xcode 11+
- iOS 11+
- Swift 5+

## Notes

- The focus is to give a taste of the code style and organization. The Unit Tests are incomplete so is the functionality of the app. 
- I've tried to use SOLID principles. No popular architecture is used (so… no MVP, MVVM, nor VIPER).
- Some basic unit tests are used. I didn't develop the app in TDD style, so that's a point for me to improve.
- The UI implementation is very basic.
- The UI is not tested but Snapshot testing would be appropriate. Recommended dependency for snapshot testing is https://github.com/pointfreeco/swift-snapshot-testing
- Other types of tests are not worth it at this point since the app is very basic. (Integration, End-to-End, and Acceptance Tests)
- Composition Root is the `AppDependencies` struct, but it doesn't have to be a single file. When the dependencies increase, the solution can grow as well.
- Time spent to implement: 1 day (2 half days)

## Dependencies

- TinyNetworking is used. The file `Endpoint.swift` is directly copied to the project to avoid the use of CocoaPods, Carthage or SPM following the mantra "The simpler the better."
- TinyConstraints was considered, but the project is too small to introduce more dependencies.

## Modules

- the folder "Features" mimics what modules might look like. Imagine an Xcode workspace with Xcode projects as modules. The `.xcconfig` files would be benefitial to manage the modules, since it is tiresome to go through every project and change their settings. For bigger projects, Xcode project generation such as Buck is recommended but it gets much more complex.
- for more info on modules, check:
    * [Strangling the Monolith Series](https://edit.theappbusiness.com/modular-ios-strangling-the-monolith-4a6843a28992)
    * [Micro-Feature Guidelines](https://github.com/tuist/microfeatures-guidelines)
