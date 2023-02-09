public protocol PWAnalyticsProtocol {
    func event(name: String)
    func scene(event: PWSceneEvent, on: String)
}

public enum PWSceneEvent: String {
    case shown, dismissed
}

public final class PWAnalytics: PWAnalyticsProtocol {
    static let shared = PWAnalytics()

    private lazy var serviceFactory: PWAnalyticsServiceFactoryProtocol = PWAnalyticsServiceFactory()
    private var service: PWAnalyticsProtocol?

    private init() {}

    public func setup(with config: PWAnalyticsConfig) {
        self.service = serviceFactory.createAnalyticsService(for: config)
    }

    public func event(name: String) {
        service?.event(name: name)
    }

    public func scene(event: PWSceneEvent, on name: String) {
        service?.scene(event: event, on: name)
    }
}

public struct PWAnalyticsConfig {
    let type: PWAnalyticsType
    let projectIdentifier: String
    let authType: PWAnalyticsAuthType
    let host: String
}

public enum PWAnalyticsAuthType {
    case apiKey(String)
}

public enum PWAnalyticsType {
    case posthog
}
