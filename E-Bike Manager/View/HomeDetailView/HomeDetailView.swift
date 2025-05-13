//
//  HomeDetailView.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct HomeDetailView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var component: Component
    var body: some View {
        VStack {
            InfoDetailView(component: component)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Component Detail View")
                    .font(.headline)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    homeViewModel.prepareForEdit(component)
                    homeViewModel.isSheetEditComponentVisible = true
                }) {
                    Image(systemName: "pencil.circle")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
            }
        }
        .sheet(isPresented: $homeViewModel.isSheetEditComponentVisible) {
            SheetEditComponent()
                .presentationDragIndicator(.visible)
                .environmentObject(homeViewModel)
                .presentationDetents([.fraction(0.9)])
        }
    }
}
