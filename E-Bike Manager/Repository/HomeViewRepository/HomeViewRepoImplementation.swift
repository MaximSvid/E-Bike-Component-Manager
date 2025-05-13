//
//  HomeviewRepoImplementation.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import SwiftUI
import FirebaseAuth

class HomeViewRepoImplementation: HomeViewRepo {
    
    private let db = FirebaseService.shared.database
    
    func createNewComponent(components: Component) throws {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "No user logged in"])
        }
        do {
            try db
                .collection("users")
                .document(userId)
                .collection("components")
                .addDocument(from: components)
        } catch {
            throw error
        }
    }
    // func für Beobachtung collection "components"
    func observeComponents(completion: @escaping (Result<[Component], any Error>) -> Void) {
        
        //überprufen ob user Exsetiert
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "No user logged in"])))
            return
        }
        // Beobachtet Änderungen in der Firestore-Collection "components"
        db.collection("users")
            .document(userId)
            .collection("components")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Prüft, ob Dokumente vorhanden sind
                guard let documents = snapshot?.documents else {
                    completion(.failure(NSError(domain: "No documents", code: -1)))
                    return
                }
                
                // Konvertiert Dokumente in Component-Objekte
                let components = documents.compactMap { document -> Component? in
                    do {
                        return try document.data(as: Component.self)
                    } catch {
                        print("Error decoding document \(error)")
                        return nil
                    }
                }
                // Gibt erfolgreich geladene Komponenten zurück
                completion(.success(components))
        }
    }
    
    func deleteComponent(componentId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        
    }
    
    func updateComponent(components: Component) throws {
        
    }
    
}
