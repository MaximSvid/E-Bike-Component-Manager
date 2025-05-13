//
//  SheetNewComponent.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct SheetNewComponent: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text("New Component")
                .font(.headline.bold())
                .padding([.top, .bottom])
            
            
            // Komponentenname
            CustomTitleRow(title: "Component Name")
            CustomTextField(placeholder: "Enter component name", text: $homeViewModel.name)
            
            // Typauswahl
            HStack {
                CustomTitleRow(title: "Type")
                
                Spacer()
                
                Picker("Component Type", selection: $homeViewModel.type) {
                    ForEach(ComponentsType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.menu)
                .tint(.gray)
                .padding(.bottom)
                
            }
            
            // Seriennummer
            CustomTitleRow(title: "Serial Number")
            CustomTextField(placeholder: "Enter serial number", text: $homeViewModel.serialNumber)
            
            // Version
            CustomTitleRow(title: "Version")
            CustomTextField(placeholder: "Enter version", text: $homeViewModel.version)
            
            
            // Status
            CustomTitleRow(title: "Status")
            Picker("Device Status", selection: $homeViewModel.status) {
                ForEach(DeviceStatus.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            // Fehlermeldung
            if let errorMessage = homeViewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding()
            }
            
            Spacer()
            
            // Erstellen-Button
            CustomMainButton(action: {
                homeViewModel.addNewComponent()
            }, title: "Create")
            .padding(.bottom, 12)
        }
        .padding([.trailing, .leading])
    }
}


