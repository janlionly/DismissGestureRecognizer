# DismissGestureRecognizer
<img src="https://media.giphy.com/media/TfLAHBp7eEnJivLNGk/giphy.gif" width="250" height="541">

[![Version](https://img.shields.io/cocoapods/v/DismissGestureRecognizer.svg?style=flat)](https://cocoapods.org/pods/DismissGestureRecognizer)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/DismissGestureRecognizer.svg?style=flat)](https://github.com/janlionly/DismissGestureRecognizer/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/DismissGestureRecognizer.svg?style=flat)](https://github.com/janlionly/DismissGestureRecognizer)
![Swift](https://img.shields.io/badge/%20in-swift%204.2-orange.svg)

## Description
**DismissGestureRecognizer** which supports to add a GestureRecognizer for Dismissing UIViewController, the gesture takes effect when a single view controller which isn't in navigationViewController or as a firstViewController in navigationViewController. Compatible with both Swift and Objective-C.

## Installation
### CocoaPods
```swift
pod 'DismissGestureRecognizer'
```

### Carthage
```swift
github "janlionly/DismissGestureRecognizer"
```

### Swift Package Manager
- iOS: Open Xcode, File->Swift Packages, search input **https://github.com/janlionly/DismissGestureRecognizer.git**, and then select Version Up to Next Major **1.0.0** < .
- Or add dependencies in your `Package.swift`:
```swift
.package(url: "https://github.com/janlionly/DismissGestureRecognizer.git", .upToNextMajor(from: "1.0.0")),
```

## Usage

Just one line code to enable the gesture for dismissing view controller:

```swift
override func viewDidLoad() {
  super.viewDidLoad()
  // types: .swipeRightForLeftEdgeScreen, .swipeRightForFullScreen, .panRightForLeftEdgeScreen, .panRightForFullScreen
  dismissType = .panRightForFullScreen
}
```

**Attention**: if set the viewController's **modalPresentationStyle** is **.fullScreen** or **.currentContext**, when dismissing viewController with the gesture, you cann't see the source viewController, replace it with a black background, so if you want to see the source viewController, please set **modalPresentationStyle** to other styles.

## Requirements

- iOS 8.0+
- Swift 4.2 to 5.2

## Author
Visit my github: [janlionly](https://github.com/janlionly)<br>
Contact with me by email: janlionly@gmail.com

## Contribute
I would love you to contribute to **DismissGestureRecognizer**

## License
**DismissGestureRecognizer** is available under the MIT license. See the [LICENSE](https://github.com/janlionly/DismissGestureRecognizer/blob/master/LICENSE) file for more info.
