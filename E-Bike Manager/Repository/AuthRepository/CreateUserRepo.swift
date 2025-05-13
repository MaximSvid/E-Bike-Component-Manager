//
//  CreateUserRepo.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

protocol CreateUserRepo {
    func registerWithEmail(email: String, password: String) async throws
}
