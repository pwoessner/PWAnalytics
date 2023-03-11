//
//  PWAnalyticsConfig.swift
//  
//
//  Created by Philipp Woessner on 11.03.23.
//

import Foundation

public struct PWAnalyticsConfig {
    public let projectIdentifier: String
    public let authType: PWAnalyticsAuthType
    public let host: String

    public init(projectIdentifier: String, authType: PWAnalyticsAuthType, host: String) {
        self.projectIdentifier = projectIdentifier
        self.authType = authType
        self.host = host
    }
}

public enum PWAnalyticsAuthType {
    case apiKey(String)
}
