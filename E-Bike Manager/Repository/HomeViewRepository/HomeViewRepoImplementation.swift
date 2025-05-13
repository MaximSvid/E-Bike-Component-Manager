//
//  HomeviewRepoImplementation.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import SwiftUI

class HomeViewRepoImplementation: HomeViewRepo {
        
    
    func createNewComponent(components: Component) throws {
        do {
            try FirebaseService.shared.database.collection("components").addDocument(from: components)
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
