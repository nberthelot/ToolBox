# ToolBox
[![Build Status](https://api.travis-ci.org/nberthelot/Toolbox.svg?branch=master)](https://travis-ci.org/nberthelot/ToolBox)
[![Version](https://img.shields.io/cocoapods/v/ToolBox.svg?style=flat)](https://cocoapods.org/pods/ToolBox)
[![License](https://img.shields.io/cocoapods/l/ToolBox.svg?style=flat)](https://cocoapods.org/pods/ToolBox)
[![Platform](https://img.shields.io/cocoapods/p/ToolBox.svg?style=flat)](https://cocoapods.org/pods/ToolBox)


ToolBox is a tookbox ;) library written in Swift.

- [Installation](#Installation)
- [Features](#features)
- [x] [Router](#Router)
- [x] Services Container
- [X] Feature flipping
- [X] Printer
- [X] Extensions (Int, Date, Array, Float, ...)
- [X] Stack type
- [x] Tabbar Controller
- [x] Pager Controller
- [X] Videos helpers ( looper, loader, ...)
- [X] UICollectionView / UITableView helpers
- [X] UI animations
- [X] UI Objects
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

## Services Container
TODO

## Feature flipping
TODO

## Printer
TBPrint allow you to print some informations and anable/diseable logging. Logger is operational only if **DEBUG** flag is enabled

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

## Stack type
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
