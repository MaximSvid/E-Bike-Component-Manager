//
//  CustomTitleRow.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct CustomTitleRow: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
            Spacer()
        }
    }
}
