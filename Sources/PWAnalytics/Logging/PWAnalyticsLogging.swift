//
//  PWAnalyticsLogging.swift
//  
//
//  Created by Philipp Woessner on 11.03.23.
//

import Logging

public class PWAnalyticsLogging {
    public static let shared = PWAnalyticsLogging()

    private init() {}

    public func setupLogging(environment: PWAnalyticsEnv) {
        LoggingSystem.bootstrap { label in
            switch environment {
            case .release:
                return PWAnalyticsLogHandler(for: label)
            default:
                return StreamLogHandler.standardError(label: label)
            }
        }
    }
}
