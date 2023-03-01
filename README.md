# `PWAnalytics`

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/pwoessner/PWAnalytics/blob/main/LICENSE)

`PWAnalytics` is a lightweight Swift package that allows you to easily switch between different analytics providers in your iOS app. 
Currently supported providers: 
- [x] [Posthog](https://posthog.com)
- [ ] Firebase
- [ ] Google Analytics
- [ ] smartlook

## Features

- Simple abstraction layer to call and log app usage
- Simple API for logging events and scene usage

## Usage
To use `PWAnalytics` in your project, import the module:

```swift
import PWAnalytics
```

In order to log events and scene usage you need to setup the `PWAnalytics` instance:
```swift
PWAnalytics.shared.setup(with: sampleConfig)
```

For the setup a specific `PWAnalyticsConfig` is needed to select the analytics provider, the project identifier, the authenticaion type and the host of the provider.

After the setup is done you can use the following code to log events and report scene events:
```swift
// Log an event
PWAnalytics.shared.event(name: "Something happened.")

// Log a scene event
PWAnalytics.shared.scene(event: .shown, on: "LoginScene")
```

---
# License
`PWAnalytics` is available under the MIT license.
