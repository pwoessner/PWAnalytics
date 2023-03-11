//
//  PWAnalytics.swift
//
//
//  Created by Philipp Woessner on 11.03.23.
//

import Foundation
import os

internal let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "PWAnalytics", category: "Providing")

public protocol PWAnalyticsProvider {
    func event(name: String)
    func scene(event: PWSceneEvent, on: String)
}

public final class PWAnalytics {
    public static let shared = PWAnalytics()

    private var provider: PWAnalyticsProvider?

    private init() {
        logger.debug("PWAnalytics shared initialized.")
    }

    public func register(provider: PWAnalyticsProvider) {
        self.provider = provider
        logger.info("Provider successfully registered.")
    }

    public func event(name: String) {
        guard let provider else {
            logger.warning("No provider registered - please register an analytics provider first.")
            return
        }

        logger.debug("Reporting app event.")
        provider.event(name: name)
    }

    public func scene(event: PWSceneEvent, on name: String) {
        guard let provider else {
            logger.warning("No provider registered - please register an analytics provider first.")
            return
        }

        logger.debug("Reporting app scene event.")
        provider.scene(event: event, on: name)
    }
}

public enum PWSceneEvent: String {
    case shown, dismissed
}
