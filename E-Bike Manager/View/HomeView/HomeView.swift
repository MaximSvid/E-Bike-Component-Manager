//
//  HomeView.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ComponentsGrid(columns: columns)
                }
                .onAppear {
                    //onAppear für daten inizializierung
                    homeViewModel.observeComponents()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("E-Bike components")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        homeViewModel.isSheetNewComponentVisible = true
                    }) {
                        Image(systemName: "plus.app")
                            .font(.headline)
                            .foregroundStyle(.black)
                    }
                }
            }
            .sheet(isPresented: $homeViewModel.isSheetNewComponentVisible) {
                SheetNewComponent()
                    .presentationDragIndicator(.visible)
                    .environmentObject(homeViewModel)
                    .presentationDetents([.fraction(0.9)])
            }
        }
    }
}

#Preview {
    HomeView()
}
