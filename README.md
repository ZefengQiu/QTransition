# QTransition

QTransition library is for easily to add customized view transitioning, in the library including Custom Presentation Controller, UINavigationController Custom Transition, Interactive UINavigationController Transitions. For detail how to use this library, please check Example project. Plus, this library provide a way to use view transition to present Menu.

## Motivation

View Transitioning has always been most complicated and difficult subject in iOS development. Meanwhile native library give few option to animation in view transitioning. Hence, I hope to build a transitioning library can help the community, if you check my code and find it is useful, that would be my pleasure.


## Customization

Welcome to folk this repo and add more cool view transitioning effects.

### How To add new type of view transition
1. It is really easy to add new type of transition, first just subclass `QBaseTransition` (checking QPushTransition as an example ), and overriding `animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, fromView: UIView, toVC: UIViewController, toView: UIView)` method;
2. And then a new case in `TransitionOptions` enum,;
3. Finally, under `QTransition`  convenience initializer, switch block, create a new case and point `self.transition` to your own custom view transitioning instance.

## Note

1.  `fromView` is a view which visible at the beginning; `toView` is a view which visiable at the end;

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 10 or newer version, Swift 4. I will be really grateful if you interested in this library and want to contribute, if you interested contribute to this repo, please follow https://github.com/raywenderlich/swift-style-guide Swift coding style.

## Installation

QTransition is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QTransition'
```

## TODO:
1. Dynamic duration based on [the Material Design Motion Guide](https://material.io/guidelines/motion/duration-easing.html). Duration is automatically determined by changes to distance and size.

## Author

Zefeng Qiu(Will), z9qiu@uwaterloo.ca

## License

QTransition is available under the MIT license. See the LICENSE file for more info.
