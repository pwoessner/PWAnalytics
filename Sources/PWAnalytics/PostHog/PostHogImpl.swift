//
//  File.swift
//  
//
//  Created by Woessner, Philipp on 09.02.23.
//

import Foundation
import PostHog

internal class PostHogImpl: PWAnalyticsProtocol {
    private let prefix: String
    private var posthog: PHGPostHog? {
        PHGPostHog.shared()
    }

    init?(with config: PWAnalyticsConfig) {
        self.prefix = config.projectIdentifier

        switch config.authType {
        case .apiKey(let apiKey):
            let configuration = PHGPostHogConfiguration(apiKey: apiKey, host: "https://" + config.host)
            PHGPostHog.setup(with: configuration)
        }
    }

    func event(name: String) {
        posthog?.capture("\(prefix) \(name)")
    }

    func scene(event: PWSceneEvent, on scene: String) {
        posthog?.screen("\(prefix) \(scene)", properties: ["Type": event.rawValue])
    }
}
