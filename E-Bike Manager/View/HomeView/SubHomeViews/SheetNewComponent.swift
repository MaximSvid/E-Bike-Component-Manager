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
        ScrollView {
            Text("New Component")
                .font(.headline)
                .padding([.top, .bottom])
            
            CustomTitleRow(title: "Component Name")
            CustomTextField(placeholder: "Enter component name", text: $homeViewModel.name)
                
            CustomTitleRow(title: "Type")
            //type soll enum sein
            
            CustomTitleRow(title: "Serial Number")
            CustomTextField(placeholder: "Enter serial number", text: $homeViewModel.serialNumber)
            
            CustomTitleRow(title: "Version")
            CustomTextField(placeholder: "Enter version", text: $homeViewModel.version)
            
            CustomTitleRow(title: "Status")
            //status soll enum sein
            
            CustomMainButton(action: {
                homeViewModel.addNewComponent()
            }, title: "Create")
            
        }
        .padding([.trailing, .leading])
    }
}

#Preview {
    SheetNewComponent()
}
