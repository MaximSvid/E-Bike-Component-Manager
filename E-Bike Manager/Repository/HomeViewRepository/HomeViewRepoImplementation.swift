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
            print("Error: No user logged in")
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
    
    //func um component zu löchen
    func deleteComponent(componentId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        
        db.collection("users")
            .document(userId)
            .collection("components")
            .document(componentId)
            .delete { error in
                if let error {
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            }
    }
    
    // Aktualisiert eine bestehende Komponente in Firestore.
    func updateComponent(components: Component) throws {
        // Prüft, ob ein Benutzer angemeldet ist
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Prüft, ob die Komponente eine gültige ID hat
        guard let componentId = components.id else {
            return
        }
        // Aktualisiert das Dokument in der Firestore
        do {
            try db.collection("users")
                .document(userId)
                .collection("components")
                .document(componentId)
                .setData(from: components, merge: true) // Merge: true sorgt dafür, dass nur geänderte Felder aktualisiert werden
        } catch {
            print("Error updating document \(error)")
            throw error
        }
    }
    
}
