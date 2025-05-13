//
//  ComponentCard.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct ComponentCard: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    let component: Component // Daten für die Karte
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
                
                Text(component.status.rawValue)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                Rectangle()
                    .fill(component.status.color)
                    .frame(width: 40, height: 20)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .padding(.horizontal, 12)
            .padding(.top, 8)
            
            Text(component.name)
                .font(.headline)
                .foregroundStyle(.black)
                .lineLimit(1) // Verhindert Textüberlauf
            
            Text("Type: \(component.type.rawValue)")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            Text("Sr Number: \(component.serialNumber)")
                .font(.caption)
                .foregroundStyle(.gray)
            
            Spacer()
            
            HStack {
                Button(action: {
                    homeViewModel.deleteComponent(component: component)
                }) {
                    Image(systemName: "trash")
                        .font(.headline)
                        .foregroundStyle(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .shadow(radius: 3)
                }
                
                Spacer()
                Text("Version: \(component.version)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 12)
            .padding(.bottom)
        }
        .padding(.leading, 8)
        .frame(width: 170, height: 170)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .shadow(radius: 3)
    }
}

struct ComponentCard_Previews: PreviewProvider {
    static var previews: some View {
        ComponentCard(component: Component(
            name: "Main Motor",
            type: .motor,
            serialNumber: "SN123456",
            version: "1.0",
            status: .active
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
