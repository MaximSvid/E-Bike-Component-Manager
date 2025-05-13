//
//  AuthWrapper.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI

struct AuthWrapper: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            if authViewModel.userIsLoggedIn {
                HomeView()
            } else {
                CreateAccount()
            }
        }
    }
}

#Preview {
    AuthWrapper()
        .environmentObject(AuthViewModel())
        .environmentObject(HomeViewModel())
}
