//
//  CreateAccount.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 12.05.25.
//

import SwiftUI

struct CreateAccount: View {
    @StateObject var viewModel: AuthViewModel
    var body: some View {
        VStack {
            CustomTextField(placeholder: "Enter your email", text: $viewModel.email)
                .padding()
            CustomTextField(placeholder: "Enter your password", text: $viewModel.password)
                .padding()
            CustomMainButton(action: {
                Task {
                  await viewModel.registerNewUser()
                }
            }, title: "Create Account")
            .padding()
        }
    }
}

#Preview {
    //    CreateAccount()
}
