//
//  PWAnalyticsLogging.swift
//  
//
//  Created by Philipp Woessner on 11.03.23.
//

import Logging

public class PWAnalyticsLogHandler: LogHandler {
    private let label: String
    private let format = " [%@-%@] %@"
    public var metadata: Logger.Metadata
    public var logLevel: Logger.Level

    public subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
        get {
            self.metadata[metadataKey]
        }
        set(newValue) {
            self.metadata[metadataKey] = newValue
        }
    }

    public init(for label: String, metadata: Logger.Metadata = [:], logLevel: Logger.Level = .info) {
        self.label = label
        self.metadata = metadata
        self.logLevel = logLevel
    }

    public func log(
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        if [.critical, .error, .warning, .info].contains(level) {
            PWAnalytics.shared.event(
                name: String(
                    format: format,
                    label,
                    level.rawValue.uppercased(),
                    message.description
                )
            )
        }
    }
}
