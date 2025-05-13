//
//  SheetNewComponent.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct SheetNewComponent: View {
    var body: some View {
        ScrollView {
            Text("New Component")
                .font(.headline)
                .padding([.top, .bottom])
            
            CustomTitleRow(title: "Component Name")
            CustomTextField(placeholder: "Enter component name", text: .constant(""))
                
            CustomTitleRow(title: "Type")
            //type soll enum sein
            
            CustomTitleRow(title: "Serial Number")
            CustomTextField(placeholder: "Enter serial number", text: .constant(""))
            
            CustomTitleRow(title: "Version")
            CustomTextField(placeholder: "Enter version", text: .constant(""))
            
            CustomTitleRow(title: "Status")
            //status soll enum sein
            
            CustomMainButton(action: {}, title: "Create")
            
        }
        .padding([.trailing, .leading])
    }
}

#Preview {
    SheetNewComponent()
}
