//
//  View+Track.swift
//  
//
//  Created by Philipp Woessner on 11.03.23.
//

import SwiftUI

public extension View {
    func track(_ scene: String) -> some View {
        modifier(AnalyticsModifier(scene))
    }
}

public struct AnalyticsModifier: ViewModifier {
    private let scene: String

    public init(_ scene: String) {
        self.scene = scene
    }

    public func body(content: Content) -> some View {
        content
            .onAppear {
                PWAnalytics.shared.scene(event: .shown, on: scene)
            }
            .onDisappear {
                PWAnalytics.shared.scene(event: .dismissed, on: scene)
            }
    }
}
