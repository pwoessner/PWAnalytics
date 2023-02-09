//
//  PWAnalyticsServiceFactory.swift
//  
//
//  Created by Woessner, Philipp on 09.02.23.
//

import Foundation

internal protocol PWAnalyticsServiceFactoryProtocol {
    func createAnalyticsService(for config: PWAnalyticsConfig) -> PWAnalyticsProtocol?
}

internal class PWAnalyticsServiceFactory: PWAnalyticsServiceFactoryProtocol {
    func createAnalyticsService(for config: PWAnalyticsConfig) -> PWAnalyticsProtocol? {
        switch config.type {
        case .posthog:
            return config.createService()
        }
    }
}

private extension PWAnalyticsConfig {
    func createService() -> PWAnalyticsProtocol? {
        switch self.type {
        case .posthog:
            return PostHogImpl(with: self)
        }
    }
}
