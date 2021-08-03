# TabbedViewController

A tabbed view controller for iOS as Android Tabbed Activity. Import using Swift Package Manager.

![tabbedview](https://user-images.githubusercontent.com/1359243/127997929-646be0b7-5826-48ee-88fb-245b45fe954a.gif)
![menu and settings](https://user-images.githubusercontent.com/1359243/128059130-730d8720-4a63-4d81-a694-bbded4ca4060.gif)

## Creating

Import module. Use .create method. For view controllers title on tabs, set .title from each UIViewController

```swift
import TabbedViewController

create(viewControllerList: [UIViewController], withHeader: Bool = true, withNavigator: Bool = true)
```
withHeader: make header visible
withNavigator: make navigator visible

## Colors

```swift
setColors(primary: UIColor, secondary: UIColor)
public var primaryColor: UIColor 
public var secondaryColor: UIColor 
```
Use function or set variables
primaryColor: Color for background for header and navigator
secondaryColor: Color for texts, and selected vc's mark

## Settings and Menu
You can add buttons for each menu. If you don't want these buttons, can hide them.
```swift
public func addSettingsAction(title: String, action: @escaping (UIAction)->()) 

public func addMenuAction(title: String, action: @escaping (UIAction)->() ) 
```
