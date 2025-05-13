//
//  HomeViewRepoMock.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import SwiftUI

class HomeViewRepoMock: HomeViewRepo {
    
    //flag
    var createComponentCalled = false
    
    var lastComponentCreated: Component?
    
    var shouldThrowError = false
    
    func createNewComponent(components: Component) throws {
        createComponentCalled = true
        
        lastComponentCreated = components
        
        if shouldThrowError {
            throw NSError(domain: "TestErrorDomain", code: 1001, userInfo: nil)
        }
    }
    
    func observeComponents(completion: @escaping (Result<[Component], any Error>) -> Void) {
        
    }
    
    func deleteComponent(componentId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        
    }
    
    func updateComponent(components: Component) throws {
        
    }
    
    
}
