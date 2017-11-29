# QLayoutor

[![CI Status](http://img.shields.io/travis/willqiu126/QLayoutor.svg?style=flat)](https://travis-ci.org/willqiu126/QLayoutor)
[![Version](https://img.shields.io/cocoapods/v/QLayoutor.svg?style=flat)](http://cocoapods.org/pods/QLayoutor)
[![License](https://img.shields.io/cocoapods/l/QLayoutor.svg?style=flat)](http://cocoapods.org/pods/QLayoutor)
[![Platform](https://img.shields.io/cocoapods/p/QLayoutor.svg?style=flat)](http://cocoapods.org/pods/QLayoutor)

Some layout helper functions (UIView extension). Help to setup UIView width, height, center in its superview, left and right padding/ margin, top and bottom layout guide / safe area.

Before setup UI programmatically, remember always set:

```Swift
uiview.translatesAutoresizingMaskIntoConstraints = false
```

## Motivation
If you used to do autolayout use storyboard, and want to try programmatically set UI Layout, this project may help you to start knowing how to set things up. Hope you find to the according operation from storyboard to code. If any weird bugs in layout show up in console, recommand a great tool: https://www.wtfautolayout.com/  -- Why The Failure Auto Layout?

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 10.0 or newer version. Swift 4.

## Installation

QLayoutor is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QLayoutor'
```

## Author

Zefeng Qiu (Will), z9qiu@uwaterloo.ca

## License

QLayoutor is available under the MIT license. See the LICENSE file for more info.
