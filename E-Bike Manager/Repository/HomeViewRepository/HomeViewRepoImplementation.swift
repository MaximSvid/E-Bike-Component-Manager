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
//            try FirebaseService.shared.database.collection("components").addDocument(from: components)
        } catch {
            throw error
        }
    }
    
    func observeComponents(completion: @escaping (Result<[Component], any Error>) -> Void) {
        
    }
    
    func deleteComponent(componentId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        
    }
    
    func updateComponent(components: Component) throws {
        
    }
    
}
