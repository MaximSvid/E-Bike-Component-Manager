//
//  ComponentsType.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

enum ComponentsType: String, Codable, CaseIterable {
    case motor = "Motor"
    case battery = "Battery"
    case wheels = "Wheels"
    case display = "Display"
}
