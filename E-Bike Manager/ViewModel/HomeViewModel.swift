//
//  HomeViewViewModel.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//
import SwiftUI


@MainActor
class HomeViewModel: ObservableObject {
    @Published var components: [Component] = []
    
    @Published var name: String = ""
    @Published var type: ComponentsType = .motor
    @Published var serialNumber: String = ""
    @Published var version: String = ""
    @Published var status: DeviceStatus = .active
    
    @Published var isSheetNewComponentVisible: Bool = false
    
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
                self.components = component
                
            case .failure(let error):
                print("Error observing components: \(error)")
            }
            
        }
    }
    
}
