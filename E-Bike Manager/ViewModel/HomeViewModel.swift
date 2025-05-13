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
    
    @Published var isSheetNewComponentVisible: Bool = false
    
    private let homeViewRepo: HomeViewRepo
    
    init(homeViewRepo: HomeViewRepo = HomeViewRepoImplementation()) {
        self.homeViewRepo = homeViewRepo
    }
    
    //fügt einen neun Component hinzu
    func addNewComponent() {
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
        } catch {
            print("Error creating new component: \(error)")
        }
    }
    
    //setzt die Eingabefelder zurück
    private func resetFields() {
        name = ""
        type = .motor
        serialNumber = ""
        version = ""
        status = .active
    }
    
}
