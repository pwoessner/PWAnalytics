//
//  PWAnalyticsDetails.swift
//  
//
//  Created by Philipp Woessner on 11.03.23.
//

import Foundation

public struct PWAnalyticsDetails {
    public enum Key: String {
        case analyticsHost = "ANALYTICS_HOST"
        case analyticsKey = "ANALYTICS_KEY"
        case environment = "ENVIRONMENT"
    }

    private let bundle: Bundle

    public init(bundle: Bundle) {
        self.bundle = bundle
    }

    public func infoString(for key: Key) -> String? {
        bundle.object(forInfoDictionaryKey: key.rawValue) as? String
    }

    public var environment: PWAnalyticsEnv? {
        guard let rawValue = infoString(for: .environment) else {
            return nil
        }

        return PWAnalyticsEnv(rawValue: rawValue)
    }
}

public enum PWAnalyticsEnv: String {
    case debug = "DEBUG"
    case release = "RELEASE"
}
