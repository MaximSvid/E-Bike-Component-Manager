//
//  AuthViewModel.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

import SwiftUI
import FirebaseAuth
import Firebase

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: FirebaseUser?
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    private let userRepo: UserRepo
    
    init(userRepo: UserRepo = UserRepoImplementation()) {
        self.userRepo = userRepo
    }
    
    func registerNewUser() async {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        do {
            try await userRepo.registerWithEmail(email: email, password: password)
            email = ""
            password = ""
        } catch {
            print("Error registering user: \(error)")
        }
    }
}
