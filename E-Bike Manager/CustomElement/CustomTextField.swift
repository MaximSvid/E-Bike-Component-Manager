//
//  CustomTextField.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 12.05.25.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .foregroundStyle(.blue)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isFocused ? .green : .blue, lineWidth: 1)
            )
            .focused($isFocused)
    }
}

