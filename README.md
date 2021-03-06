# bloggingapp iOS - MVP + Clean Architecture

## Description
Blogging is an iOS application built to highlight MVP (Model View Presenter) and Clean Architecture concepts

##  Run Requirements

Xcode 12
Swift 5

##  High Level Layers

MVP Concepts

Presentation Logic

###  View - delegates user interaction events to the Presenter and displays data passed by the Presenter
 - All UIViewController, UIView, UITableViewCell subclasses belong to the View layer
 - Usually the view is passive / dumb - it shouldn't contain any complex logic and that's why most of the times we don't need write Unit Tests for it
    
###  Presenter - contains the presentation logic and tells the View what to present
 - Usually we have one Presenter per scene (view controller)
 - It doesn't reference the concrete type of the View, but rather it references the View protocol that is implemented usually by a UIViewController subclass
 - It is a Swift class and not reference any iOS framework classes - this makes it easier to reuse it maybe in a macOS application
 - It should be covered by Unit Tests, no unit test done due to time constraint
 
 ###  Assembly - injects the dependency object into the scene (view controller) and makes visible the dependency graph
 - Usually it contains very simple logic and we don't need to write Unit Tests for it
 
 ###  Navigator - contains navigation / flow logic from one scene (view controller) to another
 - In some communities / blog posts it might be referred to as a FlowControlleror/ Router/ Coordinator

## Clean Architecture Concepts

###  Service - contains the application / business logic for a specific use case in the application
- It is referenced by the Presenter. The Presenter can reference multiple Services since it's common to have multiple use cases on the same screen
 - It manipulates Entities and communicates with Gateways/Router to retrieve / persist the entities

The separation described above ensures that the Application Logic depends on abstractions and not on actual frameworks / implementations
It should be covered by Unit Tests

###  Model - plain Swift classes / structs
Models objects used by your application such as Post, Comment etc

### Unit Test - Please note that due to limited time, I could not write unit test. 
### Dependency Manager - Added Cocoapod as a dependency manager in other to use SwiftLint to enforce Swift style and conventions in the repository
