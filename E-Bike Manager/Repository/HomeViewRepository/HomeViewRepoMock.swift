//
//  HomeViewRepoMock.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import SwiftUI

class HomeViewRepoMock: HomeViewRepo {
    
    // MARK: Add Component Tests
    var createComponentCalled = false
    var lastComponentCreated: Component?
    // Flag, um eine künstliche Fehlerauslösung zu simulieren
    var shouldThrowError = false
    
    // Simuliert das Erstellen eines neuen Komponentes
    func createNewComponent(components: Component) throws {
        createComponentCalled = true
        lastComponentCreated = components
        
        // Wenn Fehler simuliert werden sollen, wird ein Fehler ausgelöst
        if shouldThrowError {
            throw Errors.testError
        }
    }
    
    // MARK: Observe Components Test
    var observeComponentsCalled = false
    var mockedComponents: [Component] = []
    var shouldReturnMockedComponents = false
    
    func observeComponents(completion: @escaping (Result<[Component], any Error>) -> Void) {
            observeComponentsCalled = true
        
        if shouldReturnMockedComponents {
            completion(.failure(Errors.observeError))
        } else {
            completion(.success(mockedComponents))
        }
    }
    
    // MARK: Delete Component
    
    var deleteComponentCalled = false
    var deletedComponentId: String?
    var shouldDeleteThrowError = false

    func deleteComponent(componentId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        deleteComponentCalled = true
        deletedComponentId = componentId

        if shouldDeleteThrowError {
            completion(.failure(Errors.deleteError))
        } else {
            completion(.success(()))
        }
    }
    // MARK: Update Component
    
    var updateComponentCalled = false
    var lastUpdatedComponent: Component?
    var shouldThrowUpdateError = false

    func updateComponent(components: Component) throws {
        updateComponentCalled = true
        lastUpdatedComponent = components

        if shouldThrowUpdateError {
            throw Errors.updateError
        }
    }
    
    
}
