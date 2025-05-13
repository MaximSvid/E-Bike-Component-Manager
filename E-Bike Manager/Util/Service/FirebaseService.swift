//
//  FirebaseService.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import FirebaseAuth
import FirebaseFirestore

/*
 Warum man braucht FirebaseService - Wiederverwendbarkeit, Trennung der Verantwortlichkeiten, Testbarkeit
 */

class FirebaseService {
    // Statische Instanz für den Zugriff auf Firebase-Dienste
    static let shared = FirebaseService()
    // Authentifizierungsobjekt von Firebase
    let auth = Auth.auth()
    
    let database = Firestore.firestore()
    
    private init() {
            // Private Initialisierung, um sicherzustellen, dass nur eine Instanz existiert
        }

}
