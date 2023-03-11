//
//  PWAnalyticsProvider.swift
//  
//
//  Created by Philipp Woessner on 11.03.23.
//

import Foundation

public protocol PWAnalyticsProvider {
    func event(name: String)
    func scene(event: PWSceneEvent, on: String)
}
