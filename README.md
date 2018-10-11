# ToolBox

[![Build Status](https://travis-ci.org/nberthelot/ToolBox.svg?branch=master)](https://travis-ci.org/nberthelot/ToolBox)
[![Version](https://img.shields.io/cocoapods/v/ToolBox.svg?style=flat)](https://cocoapods.org/pods/ToolBox)
[![License](https://img.shields.io/cocoapods/l/ToolBox.svg?style=flat)](https://cocoapods.org/pods/ToolBox)
[![Platform](https://img.shields.io/cocoapods/p/ToolBox.svg?style=flat)](https://cocoapods.org/pods/ToolBox)

ToolBox is a toolbox ;) library written in Swift.

- [Installation](#installation)
- [Features](#router)
  - [Router](#router)
  - [Container](#container)
  - [Services](#services)
  - [Feature flipping](#feature-flipping)
  - [Printer](#printer)
  - [TBReusable](#tbreusable)
  - [Other](#other)
- [Example](#example)
- [Requirements](#requirements)
- [Author](#Author)

# Installation

ToolBox is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ToolBox'
```

##  Router

Router will help you to manage routes and navigation through the application.

A route is a class (in most cases a `UIViewController`) which implements TBRoutable protocol:
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

Routes can be added manually:

```swift
TBRouter.addRoute("home", routableClass: HomeViewController.self)
```
Or with local or remote router file (JSON):
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

To perform a route just call `x_performRoute` from `UIViewController`:
```swift
x_performRoute("home", presentationType: .push)
//or
x_performRoute("home", presentationType: .modal, data: someData, animated: true)
```

Or just get the route's controller and perform a presentation programmatically:
```swift
let homeController = TBRouter.route("home", with: someData)
```

## Container

`TBContainer` is a key/value RAM storage
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
Be careful: `TBContainer` doesn't work with inheritance, **`set` and `get` need to use the same type**
```swift
TBContainer.add(myCollectionView, for: "collectionView")
let view: UIView? = TBContainer.getValue(for: "collectionView") // nil
let collectionView: UICollectionView? = TBContainer.getValue(for: "collectionView") // myCollectionView
```

## Services

`TBServices` is a service container. 
To create a service and make it available:
* Create `MyServiceProtocol` protocol, witch inherits `TBServiceProtocol`
* Create your service which implements the previous protocol and `TBServiceProtocol`
* Add the service to `TBServices`

```swift
protocol MyServiceProtocol: TBServiceProtocol {
  // Add methods
}

final class MyService: MyServiceProtocol {
  // Add protocol implementation
  static func loadService() -> MyService {
    return MyService() // Service can be a singleton or not
  }
}

// Add service
TBServices.add(MyService.self, for: MyServiceProtocol.self)

// Retrieve service
let service: MyServiceProtocol = TBServices.retrieve()
// or
TBServices.retrieve(type: MyServiceProtocol.self)
```

**Be careful: the service needs to be added before being retrieved**

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
TBFeature.isEnabled(.foo) // false
```

Notification is sent when feature status did change (`tbFeaturesDidChange`):

```swift
NotificationCenter.default.addObserver(forName: .tbFeaturesDidChange, object: nil, queue: .main) { (notif) in
  if TBFeature.feature(.foo, matchNotification: notif) {
    // Foo feature status did change
  }
}
```

## Printer

`TBPrint` allow you to print informations and toggle logging. Logger is operational only if **DEBUG** flag is enabled.

```swift
tbPrint("message", category: .ui)
tbDebugPrint("message", category: .ui)
```

To create a new category, just add:
```swift
extension TBPrint.Category {
  static let foo = TBPrint.Category("foo")
}

tbPrint("message", category: .foo)
```


Default Categories are :
* `network`
* `database`
* `data`
* `file`
* `service`
* `ui`
* `none`
* `all`

You can select which categories are logged:

```swift
TBPrint.categories = [PrintCategory.ui, PrintCategory.file]
//or
TBPrint.categories = [PrintCategory.all]

```


## TBReusable

TBReusable is a protocol for cells (`UICollectionView` and `UITableViewCell`) which simplify cell registration and cell dequeue.

```swift
public class MyTableViewCell: UITableViewCell, TBReusable {

}

// Register
tableView.x_registerReusableCell(MyTableViewCell.self)

// Dequeue
let cell: MyTableViewCell = tableView.x_dequeueReusableCell(indexPath: indexPath)
```

## Other

ToolBox contains other undocumented features like:
- Tabbar with custom tabbar items
- Pager with custom transitions
- Some extensions (`Date`, `Array`, `Float`, `String`, `AVURLAsset`, `UIViewController`...)
- `UIObject`

# Requirements

- iOS 10.0+ / macOS 10.10+ / tvOS 10.0+
- Xcode 9.4+
- Swift 4.2+

# Example

To run the example project, clone the repository, and run `pod install` from the `Example` directory first.

# Author

Nicolas Berthelot

# License

ToolBox is available under the MIT license. See the LICENSE file for more informations.
