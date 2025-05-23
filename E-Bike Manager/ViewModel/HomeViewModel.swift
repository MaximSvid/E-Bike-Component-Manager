//
//  HomeViewViewModel.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import SwiftUI


@MainActor
class HomeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var type: ComponentsType = .motor
    @Published var serialNumber: String = ""
    @Published var version: String = ""
    @Published var status: DeviceStatus = .active
    
    @Published var components: [Component] = []
    @Published var selectedComponent: Component?
    
    @Published var isSheetNewComponentVisible: Bool = false
    @Published var isSheetEditComponentVisible: Bool = false
    
    @Published var errorMessage: String?
    
    private let homeViewRepo: HomeViewRepo
    
    init(homeViewRepo: HomeViewRepo = HomeViewRepoImplementation()) {
        self.homeViewRepo = homeViewRepo
    }
    
    //fügt einen neun Component hinzu
    func addNewComponent() {
        
        guard !name.isEmpty else {
            errorMessage = "Please enter the component name."
            return
        }
        
        guard !serialNumber.isEmpty else {
            errorMessage = "Please enter the serial number."
            return
        }
        
        guard !version.isEmpty else {
            errorMessage = "Please enter the version."
            return
        }
        
        let newComponent = Component(
            name: name,
            type: type,
            serialNumber: serialNumber,
            version: version,
            status: status)
        
        do {
            try homeViewRepo.createNewComponent(components: newComponent)
            resetFields()
            isSheetNewComponentVisible = false
            errorMessage = nil
        } catch {
            print("Error creating new component: \(error)")
        }
    }
    
    //setzt die Eingabefelder zurück
    func resetFields() {
        name = ""
        type = .motor
        serialNumber = ""
        version = ""
        status = .active
    }
    
    func observeComponents() {
        homeViewRepo.observeComponents { result in
            switch result {
            case .success(let component):
                self.components = component.sorted {$0.status.sortOrder < $1.status.sortOrder} //sortierung nach status
                
            case .failure(let error):
                print("Error observing components: \(error)")
            }
            
        }
    }
    
    //Entfernt einen Component
    func deleteComponent(component: Component) {
        guard let componentId = component.id else {
            print("Error deleting component: componentId is nil")
            return
        }
        
        homeViewRepo.deleteComponent(componentId: componentId) { result in
            switch result {
            case .success:
                if let index = self.components.firstIndex(where: { $0.id == componentId}) {
                    self.components.remove(at: index)
                }
                print("Component deleted successfully")
                
            case .failure(let error):
                print("Error deleting component: \(error)")
            }
        }
    }
    
    // Bereitet einen Component für die Bearbeitung vor
    func prepareForEdit(_ component: Component) {
        self.selectedComponent = component
        self.name = component.name
        self.type = component.type
        self.serialNumber = component.serialNumber
        self.version = component.version
        self.status = component.status
    }
    
    // Aktualisiert einen bestehenden Component
    func updateComponent() {
        guard let existingComponent = selectedComponent,
              let componentId = existingComponent.id else {
            print("Error updating component: componentId is nil")
            return
        }
        
        let updatedComponent = Component(
            id: componentId,
            name: name,
            type: type,
            serialNumber: serialNumber,
            version: version,
            status: status
        )
        do {
            try homeViewRepo.updateComponent(components: updatedComponent)
            if let index = components.firstIndex(where: {$0.id == existingComponent.id} ) {
                components[index] = updatedComponent
                print("Component updated successfully")
            }
        } catch {
            print("Error updating component: \(error)")
        }
    }
    
    
}
