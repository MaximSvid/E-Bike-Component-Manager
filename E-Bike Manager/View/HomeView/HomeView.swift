//
//  HomeView.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("E-Bike components")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus.app")
                            .font(.headline)
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
