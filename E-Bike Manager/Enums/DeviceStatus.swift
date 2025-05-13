//
//  DeviceStatus.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import SwiftUI

enum DeviceStatus: String, Codable {
    case active = "Active"
    case inactive = "Inactive"
    case waiting = "Waiting"
    
    var color: Color {
        switch self {
        case .active:
            return .green
        case .inactive:
            return .red
        case .waiting:
            return .yellow
        }
    }
}
