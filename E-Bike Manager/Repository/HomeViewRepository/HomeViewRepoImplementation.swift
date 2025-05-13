//
//  HomeviewRepoImplementation.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import SwiftUI

class HomeViewRepoImplementation: HomeViewRepo {
    
    func createNewComponent(componentsType: ComponentsType) throws {
        do {
            try FirebaseService.shared.database.collection("components").addDocument(from: componentsType)
        } catch {
            throw error
        }
    }
    
    func observeComponents(completion: @escaping (Result<[ComponentsType], any Error>) -> Void) {
        
    }
    
    func deleteComponent(componentId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        
    }
    
    func updateComponent(componentsType: ComponentsType) throws {
        
    }
    
    
}
