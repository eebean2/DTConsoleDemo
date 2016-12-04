# DTConsoleDemo
An on-device console for debugging purpose on iOS and tvOS. This version is a demo version, only capable of running on iOS.

##Setup

Getting started is simple! Drag and drop DTConsoleDemo.swift into your project (make sure "Copy if Needed" is checked) then all you have to do is type the following lines in what ever view you will the console to appear in:

```swift
let console = DTConsoleDemo.SharedInstance
console.setup(in: view) // view will be your UIView
console.display() // will display on the view
```

##Custimization

In this demo, you may not custimize very much, but here are the few items you can (with their defaults):

```swift
DTConsoleDemo.Settings.textColor = UIColor.green
DTConsoleDemo.Settings.errorColor = UIColor.red
DTConsoleDemo.Settings.backgroundColor = UIColor.black
```

You can also set the console to not run when the app is launched (known as Live Override) by setting the following code:

```swift
DTConsoleDemo.Settings.liveOverride = true
```

##Printing to the Console
Prining is as simple as calling `print` on the console. You have two options, `print()` and `print(_:, method:)` for when you wish to also print to Xcode or both.

You can also `printError()`, and the same with normal print, `printError(_:, method:)` to print to Xcode or both as well.

#Full Version
Now available here: https://github.com/eebean2/DTConsole
Want more custimization? How about a popover? With the full version you get all that and more!

###Design
 - Cocapod Support with `Pod DTConsole`
 - Side console from left/right
 - Custom size
 - Gesture support

###Console Types
 - Popover Console
 - Custom Commands w/ Text Input
 - Fullscreen Console
 - tvOS Support
 - Dragable Console on iPad (in development)

###Options
 - Individual Width OR Height Override
 - Starting Point Override
 - Gesture Support
 - Print a Warning Message
 - Print a Diagnost Message
