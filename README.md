<h1 align="center">
    PWAnalytics
</h1>

<p align="center">
    <a href="https://github.com/pwoessner/PWAnalytics/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-MIT-blue.svg">
    </a>
    <a href="https://github.com/pwoessner/PWAnalytics/actions/workflows/swift.yml">
        <img src="https://github.com/pwoessner/PWAnalytics/actions/workflows/swift.yml/badge.svg?event=pull_request">
    </a>
    <img src="https://img.shields.io/badge/platform-iOS-lightgrey.svg">
    <img src="https://img.shields.io/badge/Swift-5.7-F16D39.svg">
</p>

`PWAnalytics` is a lightweight Swift package that abstracts an analytics provider to easily switch or implement custom analytics solutions.
The main focus is to log events and report scene usages of an user. 
Additionally, it enables [swift-log](https://github.com/apple/swift-log) to automatically log relevant log messages to the analytics provider as a custom event.
 
## Features

- Simple abstraction layer to call and log app usage
- `PWAnalytics` can log and scene events
- `Logger` from [swift-log](https://github.com/apple/swift-log) will automatically upload logs also to the provider as an event if setup

## Configuration
The following `Info.plist` variables can be maintained but is optional:
```xcconfig
ENVIRONMENT = RELEASE
ANALYTICS_HOST = HOST
ANALYTICS_KEY = KEY
```

With this configuration in the `Info.plist` you can use the `PWAnalyticsDetails` convenience struct to read the configuration and create an `PWAnalyticsConfig` object. 
Different approaches are also possible.

## Usage

### Analytics
To use `PWAnalytics` in your project, import the module:

```swift
import PWAnalytics
```

In order to log events and scene usage you first need to create your analytics provider and implement the the functions of the Provider protocol:

```swift
public protocol PWAnalyticsProvider {
    func event(name: String)
    func scene(event: PWSceneEvent, on: String)
}
```

Example for [PostHog](https://posthog.com):
```swift
import PostHog
import PWAnalytics

class PostHogProvider: PWAnalyticsProvider {
    private var posthog: PHGPostHog? {
        PHGPostHog.shared()
    }

    init?(with config: PWAnalyticsConfig) {
        switch config.authType {
        case .apiKey(let apiKey):
            let configuration = PHGPostHogConfiguration(apiKey: apiKey, host: "https://" + config.host)
            PHGPostHog.setup(with: configuration)
        }
    }

    func event(name: String) {
        posthog?.capture(name)
    }

    func scene(event: PWSceneEvent, on scene: String) {
        posthog?.screen(scene, properties: ["Type": event.rawValue])
    }
}
```

After creating your provider you need to make sure to register it:
```swift
// Abstraction to load analytics details from the Info.plist file to set the in a `.xcconfig` file
let details = PWAnalyticsDetails(bundle: Bundle.main)

guard
    let host = details.infoString(for: .analyticsHost),
    !host.isEmpty,
    let key = details.infoString(for: .analyticsKey),
    !key.isEmpty
else {
    appLogger.warning("Analytics details not maintained.")
    return
}

let config = PWAnalyticsConfig(
    projectIdentifier: Bundle.main.bundleIdentifier ?? "AppName",
    authType: .apiKey(key),
    host: host
)

guard let provider = PostHogProvider(with: config) else {
    appLogger.warning("Analytics Provider could not be initialized with the config provided.")
    return
}

PWAnalytics.shared.register(provider: provider)
```

After the provider is registered you can use the following code to log events and report scene events:
```swift
// Log an event
PWAnalytics.shared.event(name: "Something happened.")

// Log a scene event
PWAnalytics.shared.scene(event: .shown, on: "LoginScene")
```

### Logging
To automatically log events from Apple's swift-log package to the analytics provider you need to create a `Logger` instance and setup logging:
 ```swift
import Foundation
import Logging
import PWAnalytics

let appLogger = Logger(label: "App")

func setupLogging() {
    let environment = PWAnalyticsDetails(bundle: .main).environment ?? .debug
    PWAnalyticsLogging.shared.setupLogging(environment: environment)
}
```

Depending on the environment a cusomt LogHandler is used to report log messages as an event to the provider.

---
# License
`PWAnalytics` is available under the MIT license.
