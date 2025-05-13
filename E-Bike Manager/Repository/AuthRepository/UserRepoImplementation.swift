//
//  CreateUserRepoImplementation.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import SwiftUI
import Firebase

class UserRepoImplementation: UserRepo {
    private let fb = FirebaseService.shared
    func registerWithEmail(email: String, password: String) async throws {
        let result = try await fb.auth.createUser(withEmail: email, password: password)
        let user = FirebaseUser(id: result.user.uid)
        
        try fb.database
            .collection("users")
            .document(result.user.uid)
            .setData(from: user)
    }
}
