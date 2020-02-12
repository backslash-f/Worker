[![swift-version](https://img.shields.io/badge/swift-5.1-brightgreen)](https://github.com/apple/swift)
[![swift-package-manager](https://img.shields.io/badge/package%20manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![build-status](https://travis-ci.org/backslash-f/Worker.svg?branch=master)](https://travis-ci.org/backslash-f/Worker)
[![license](https://img.shields.io/badge/license-mit-brightgreen.svg)](https://en.wikipedia.org/wiki/MIT_License)

# Worker
Execute async code in the main or background threads. Easily switch between them.

## Usage
```swift
import Worker

// Execute code in a background thread.
Worker.doBackgroundWork {
	print("Background thread work...")
}

// Execute code in the main thread.
Worker.doMainThreadWork {
	print("Main thread work...")
}

// Execute code in a background thread and update the UI afterwards.
Worker.doBackgroundWork {
	print("Something expensive...")

    Worker.doMainThreadWork {
    	print("Update the UI.")
    }
}
```
Worker's background threads use QoS `.userInitiated` to execute code asynchronously with a higher priority.  
[From Apple](https://developer.apple.com/documentation/dispatch/dispatchqos/qosclass/userinitiated):

> User-initiated tasks are second only to user-interactive tasks in their priority on the system. Assign this class to tasks that provide immediate results for something the user is doing, or that would prevent the user from using your app. For example, you might use this quality-of-service class to load the content of an email that you want to display to the user.

## Integration
### Xcode
Use Xcode's [built-in support for SPM](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

### Package.swift
In your `Package.swift`, add `Worker` as a dependency:
```swift
dependencies: [
  .package(url: "https://github.com/backslash-f/Worker", from: "1.0.0")
],
```

Associate the dependency with your target:
```swift
targets: [
  .target(name: "App", dependencies: ["Worker"])
]
```

Run: `swift build`
