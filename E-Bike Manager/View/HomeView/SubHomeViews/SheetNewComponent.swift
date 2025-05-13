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
//        ScrollView {
            VStack {
                Text("New Component")
                    .font(.headline)
                    .padding([.top, .bottom])
                
                
                
                // Komponentenname
                CustomTitleRow(title: "Component Name")
                    .padding(.top, 20)
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
                .padding(.bottom)

//            }                        
        }
        .padding([.trailing, .leading])
    }
}


