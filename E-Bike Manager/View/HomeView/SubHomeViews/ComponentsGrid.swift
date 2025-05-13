//
//  ComponentsGrid.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct ComponentsGrid: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    let columns: [GridItem]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(homeViewModel.components, id: \.id) { component in
//                NavigationLink(destination: HomeDetailView(component: component)) {
                    ComponentCard(component: component)
//                }
            }
        }
        .padding(.horizontal, 16)
    }
}

