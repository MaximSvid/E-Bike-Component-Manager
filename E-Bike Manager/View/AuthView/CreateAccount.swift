//
//  CreateAccount.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 12.05.25.
//

import SwiftUI

struct CreateAccount: View {
    @StateObject var authViewModel: AuthViewModel
    @StateObject var homeViewModel: HomeViewModel
    
    var body: some View {
        
        VStack {
            
            CustomTextField(placeholder: "Enter your email", text: $authViewModel.email)
                .padding()
            
            CustomTextField(placeholder: "Enter your password", text: $authViewModel.password)
                .padding()
            
            CustomMainButton(action: {
                Task {
                  await authViewModel.registerNewUser()
                }
            }, title: "Create Account")
            .padding()
        }
    }
}

#Preview {
//        CreateAccount()
//        .environmentObject(AuthViewModel())
//        .environmentObject(HomeViewModel())
}
