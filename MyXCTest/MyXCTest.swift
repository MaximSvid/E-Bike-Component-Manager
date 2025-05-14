//
//  MyXCTest.swift
//  MyXCTest
//
//  Created by Maxim Svidrak on 13.05.25.
//

import XCTest
@testable import E_Bike_Manager

final class MyXCTest: XCTestCase {
    
    // Variablen zur Vorbereitung des Tests
    var viewModel: HomeViewModel!
    var mockRepo: HomeViewRepoMock!
    
    // Wird vor jedem Test ausgeführt, um die Testumgebung vorzubereiten
    override func setUp() {
        super.setUp()
        
        // Erstellen des Mock-Repositories
        mockRepo = HomeViewRepoMock()
        
        // Initialisierung des ViewModels im MainActor-Kontext (asynchron)
        let expectation = XCTestExpectation(description: "Initialize ViewModel")
        
        Task { @MainActor in
            viewModel = HomeViewModel(homeViewRepo: mockRepo)
            expectation.fulfill()
        }
        
        // Warten auf die Initialisierung
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Wird nach jedem Test aufgerufen, um die Ressourcen freizugeben
    override func tearDown() {
        viewModel = nil
        mockRepo = nil
        super.tearDown()
    }
    // MARK: Add New Component Test
    
    // Testfall: Erfolgreiches Hinzufügen eines neuen Komponentes
    func testAddNewComponentSuccess() async throws {
        await MainActor.run {
            // Festlegen der Eingabewerte
            viewModel.name = "Test Component"
            viewModel.serialNumber = "SN123456"
            viewModel.version = "1.0"
            
            // Aufruf der Hinzufügen-Funktion
            viewModel.addNewComponent()
        }
        
        // Überprüfen, ob der Mock korrekt aufgerufen wurde
        XCTAssertTrue(mockRepo.createComponentCalled)
        XCTAssertEqual(mockRepo.lastComponentCreated?.name, "Test Component")
        XCTAssertEqual(mockRepo.lastComponentCreated?.serialNumber, "SN123456")
        XCTAssertEqual(mockRepo.lastComponentCreated?.version, "1.0")
        
        await MainActor.run {
            // Überprüfen, ob das Eingabeformular geschlossen wurde
            XCTAssertFalse(viewModel.isSheetNewComponentVisible)
        }
    }
    
    // MARK: Observe Components Tests
    
    func testObserveComponentsFailure() async throws {
        mockRepo.shouldReturnMockedComponents = true
        
        await MainActor.run {
            viewModel.observeComponents()
        }
        
        XCTAssertTrue(mockRepo.observeComponentsCalled)
        
        await MainActor.run {
            XCTAssertEqual(viewModel.components.count, 0)
        }
    }
    
    // MARK: Delete Components Tests
    
    func testDeleteComponentSuccess() async throws {
        let component = Component(id: "123", name: "Test", type: .motor, serialNumber: "SN1", version: "1", status: .active)

        await MainActor.run {
            viewModel.components = [component]
            viewModel.deleteComponent(component: component)
        }

        XCTAssertTrue(mockRepo.deleteComponentCalled)
        XCTAssertEqual(mockRepo.deletedComponentId, "123")

        await MainActor.run {
            XCTAssertTrue(viewModel.components.isEmpty)
        }
    }
    
    func testDeleteComponentFailure() async throws {
        let component = Component(id: "1", name: "Motor", type: .motor, serialNumber: "SN", version: "1.0", status: .active)
        mockRepo.shouldDeleteThrowError = true

        await MainActor.run {
            viewModel.components = [component]
            viewModel.deleteComponent(component: component)
        }

        XCTAssertTrue(mockRepo.deleteComponentCalled)

        await MainActor.run {
            XCTAssertEqual(viewModel.components.count, 1) // компонент не удалён!
        }
    }
    
}
