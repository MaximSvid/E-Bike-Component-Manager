//
//  MyXCTest.swift
//  MyXCTest
//
//  Created by Maxim Svidrak on 13.05.25.
//

import XCTest
@testable import E_Bike_Manager

final class MyXCTest: XCTestCase {
    
    // Объявление переменных для теста
    var viewModel: HomeViewModel!
    var mockRepo: HomeViewRepoMock!
    
    // Используем setUp вместо setUpWithError для асинхронной инициализации
    override func setUp() {
        super.setUp()
        
        // Создаем мок-репозиторий
        mockRepo = HomeViewRepoMock()
        
        // Инициализация ViewModel в главном потоке
        let expectation = XCTestExpectation(description: "Initialize ViewModel")
        
        Task { @MainActor in
            // Создаем ViewModel в контексте MainActor
            viewModel = HomeViewModel(homeViewRepo: mockRepo)
            expectation.fulfill()
        }
        
        // Ждем завершения инициализации
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    override func tearDown() {
        viewModel = nil
        mockRepo = nil
        super.tearDown()
    }
    
    func testAddNewComponentSuccess() async throws {
        await MainActor.run {
            // Устанавливаем значения полей
            viewModel.name = "Test Component"
            viewModel.serialNumber = "SN123456"
            viewModel.version = "1.0"
            
            // Вызываем метод добавления компонента
            viewModel.addNewComponent()
        }
        
        // Проверяем результаты
        XCTAssertTrue(mockRepo.createComponentCalled)
        XCTAssertEqual(mockRepo.lastComponentCreated?.name, "Test Component")
        XCTAssertEqual(mockRepo.lastComponentCreated?.serialNumber, "SN123456")
        XCTAssertEqual(mockRepo.lastComponentCreated?.version, "1.0")
        
        await MainActor.run {
            XCTAssertFalse(viewModel.isSheetNewComponentVisible)
        }
    }
    
    // Тест с пустым именем
    func testAddNewComponentEmptyName() async throws {
        await MainActor.run {
            viewModel.name = ""
            viewModel.serialNumber = "SN123456"
            viewModel.version = "1.0"
            
            viewModel.addNewComponent()
        }
        
        XCTAssertFalse(mockRepo.createComponentCalled)
        
        await MainActor.run {
            XCTAssertEqual(viewModel.errorMessage, "Please enter the component name.")
        }
    }
    
    // Тест с ошибкой от репозитория
    func testAddNewComponentWithError() async throws {
        await MainActor.run {
            viewModel.name = "Test Component"
            viewModel.serialNumber = "SN123456"
            viewModel.version = "1.0"
        }
        
        // Настраиваем мок на генерацию ошибки
        mockRepo.shouldThrowError = true
        
        await MainActor.run {
            viewModel.addNewComponent()
        }
        
        XCTAssertTrue(mockRepo.createComponentCalled)
        
        await MainActor.run {
            // Проверяем, что форма закрывается даже при ошибке
            XCTAssertFalse(viewModel.isSheetNewComponentVisible)
        }
    }
}
