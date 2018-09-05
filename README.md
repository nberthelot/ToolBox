# ToolBox
[![Build Status](https://api.travis-ci.org/nberthelot/Toolbox.svg?branch=master)](https://travis-ci.org/nberthelot/ToolBox)
[![Version](https://img.shields.io/cocoapods/v/ToolBox.svg?style=flat)](https://cocoapods.org/pods/ToolBox)
[![License](https://img.shields.io/cocoapods/l/ToolBox.svg?style=flat)](https://cocoapods.org/pods/ToolBox)
[![Platform](https://img.shields.io/cocoapods/p/ToolBox.svg?style=flat)](https://cocoapods.org/pods/ToolBox)


ToolBox is a tookbox ;) library written in Swift.

- [Installation](#Installation)
- [Features](#features)
- Router
- Container
- Services
- Feature flipping
- Printer (#Router)
- Extensions (Int, Date, Array, Float, ...)
- Tabbar Controller
- Pager Controller
- Videos helpers ( looper, loader, ...)
- UICollectionView / UITableView helpers
- UI animations
- UI Objects
- [Example](#Example)
- [Requirements](#requirements)
- [Author](#Author)

# Installation

ToolBox is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ToolBox'
```

##  Router

Router will help you to manage routes and navigation throw the application

A route is a class (in most of the cases a ViewController) witch implements TBRoutable protocol
```swift
public protocol TBRoutable: class {
  static func loadController(with data: Any?, for route: String) -> UIViewController?
}
```
Example:
```swift
class HomeViewController: UIViewController, TBRoutable {
  public static func loadController(with data: Any?, for route: String) -> UIViewController? {
    //You can add some logic like data validation
    return self.init()
  }
}
```

Routes can be added manually 

```swift
TBRouter.addRoute("home", routableClass: HomeViewController.self)
```
Or with local or remote router file (JSON)
*Routes.json*
```json
{
  "home": {
    "class" : "HomeViewController"
  },
}
```

```swift
if let url = Bundle.main.url(forResource: "Routes", withExtension: "json") {
  TBRouter.loadRoutes(from: url)
}
```

To perform a route just call from UIViewController:
```swift
x_performRoute("home", presentationType: .push)
//or
x_performRoute("home", presentationType: .modal, data: someData, animated: true)
```

Or just get the route's controller and perform a presentation manually:
```swift
let homeController = TBRouter.route("home", with: someData)
```

## Container

TBContaire is a Key/value RAM storage
```swift
//Set
TBContainer.add(1, for: "key")
//Get
let val: Int? = TBContainer.getValue(for: "key")
//Remove
val = TBContainer.removeValue(for: "key")
```
Keys are associated with value type so same key can be reused
```swift
TBContainer.add(1, for: "key")
TBContainer.add("Hello", for: "key")

let val: Int? = TBContainer.getValue(for: "key") // 1
let val: String? = TBContainer.getValue(for: "key") // "Hello"
```
Be careful TBContainer doesn't work with inheritance, **Set and Get need to use same Type**
```swift
TBContainer.add(myCollectionView, for: "view")
let view: UIView? = TBContainer.getValue(for: "collectionView") // nil
let collectionView: UICollectionView? = TBContainer.getValue(for: "collectionView") // myCollectionView
```

## Services

TBServices is a service container. 
To create service and make it available:
* Create Service protocol, witch inherits to TBServiceProtocol
* Create service witch implement the previous protocol and TBServiceProtocol
* Add service to TBServices

```swift
protocol MyServiceProtocol: TBServiceProtocol {
  //Add methodes
}

final class MyService: MyServiceProtocol {
  //Add protocol implementation
  static func loadService() -> MyService {
    return MyService() // Service can be a singleton or not
  }
}

//Add service
TBServices.add(MyService.self, for: MyServiceProtocol.self)

// Retrieve service
let service: MyServiceProtocol = TBServices.retrieve()
//or
TBServices.retrieve(type: MyServiceProtocol.self)
```

**Be careful Service needs to be added before retrieved**

## Feature flipping
You can create a new feature definition
```swift
extension TBFeature.Name {
  public static let foo = TBFeature.Name("foo")
  public static let bar = TBFeature.Name("bar")
}
```
And set/get feature status.
```swift
// Set
TBFeature.set(.foo, enabled: true)
TBFeature.set(.foo, enabled: false)
// Get
TBFeature.isEnabled(.foo)
```
Notification is sent when feature status did change (**tbFeaturesDidChange**)
```swift
NotificationCenter.default.addObserver(forName: .tbFeaturesDidChange, object: nil, queue: .main) { (notif) in
  if TBFeature.feature(.foo, matchNotification: notif) {
    // Foo feature status did change
  }
}
```
## Printer
TBPrint allow you to print some information and enable/disable logging. Logger is operational only if **DEBUG** flag is enabled

```swift
tbPrint("message", category: .ui)
tbDebugPrint("message", category: .ui)
```

Categories are :
* network
* database
* data
* file
* service
* ui
* none

You can select categories logged:
```swift
TBPrint.categories = [PrintCategory.ui, PrintCategory.file]
```


## Extensions
TODO

## Tabbar Controller
TODO

## Pager Controller
TODO

## Videos helpers 
TODO

## UICollectionView / UITableView helpers
TODO

## UI animations
TODO

## UI Objects
TODO

# Requirements

- iOS 10.0+ / macOS 10.10+ / tvOS 10.0+
- Xcode 9.4+
- Swift 4.1+

# Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

# Author
Berthelot nicolas

# License

ToolBox is available under the MIT license. See the LICENSE file for more info.
