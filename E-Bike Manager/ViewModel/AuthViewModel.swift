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
        
        setupAuthStateListener() // Richtet den Listener für Änderungen des Authentifizierungsstatus ein
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
    
    // Gibt zurück, ob ein Benutzer angemeldet ist
    var userIsLoggedIn: Bool {
        user != nil
    }
    
    /*
     Die Variable private var authStateHandle: AuthStateDidChangeListenerHandle? und die Methode setupAuthStateListener werden verwendet, um mit dem Firebase Authentication-System zu arbeiten, um Änderungen im Authentifizierungsstatus des Benutzers zu verfolgen (z. B. Anmeldung, Abmeldung oder Registrierung).
     | Die Methode setupAuthStateListener richtet einen Listener ein, der automatisch von Firebase aufgerufen wird, sobald sich der Authentifizierungsstatus des Benutzers ändert. | [weak self] wird verwendet, um einen starken Referenzzyklus (Retain Cycle) zwischen AuthViewModel und dem Closure zu vermeiden. Ohne dies könnte das Closure eine starke Referenz auf self (die Instanz von AuthViewModel) halten, was zu einem Speicherleck führen könnte.
     | guard let self = self else { return } überprüft, ob self noch existiert, und entpackt die schwache Referenz.
     */
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    // setupAuthStateListener richtet einen Listener ein, der automatisch von Firebase aufgerufen wird, sobald sich der Authentifizierungsstatus des Benutzers ändert
    private func setupAuthStateListener() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, firebaseUser in
            guard let self = self else { return }
            print("Auth state changed: \(firebaseUser?.uid ?? "No user")") // log
            self.user = firebaseUser != nil ? FirebaseUser(id: firebaseUser!.uid) : nil
        }
    }
}
