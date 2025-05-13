//
//  InfoDetailView.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct InfoDetailView: View {
    var component: Component
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Spacer()
                
                Text(component.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
//                    .padding(.top, 10)
                    .lineLimit(1)
                
                Spacer()
            }
            
            HStack {
                Text("Status: \(component.status.rawValue)")
                    .font(.headline)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Rectangle()
                    .fill(component.status.color)
                    .frame(width: 100, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
            
            
            VStack(alignment: .leading, spacing: 12) {
                CustomInfoRow(label: "Type", value: component.type.rawValue)
                CustomInfoRow(label: "Serial Number", value: component.serialNumber)
                CustomInfoRow(label: "Version", value: component.version)
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

//#Preview {
//    InfoDetailView()
//}
