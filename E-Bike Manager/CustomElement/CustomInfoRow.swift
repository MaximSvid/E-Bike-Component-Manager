//
//  CustomInfoRow.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct CustomInfoRow: View {
    let label: String
        let value: String
        
        var body: some View {
            HStack {
                Text(label + ":")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .frame(width: 120, alignment: .leading)
                
                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
}
