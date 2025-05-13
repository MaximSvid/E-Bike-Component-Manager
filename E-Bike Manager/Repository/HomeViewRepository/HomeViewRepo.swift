//
//  HomeViewRepo.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

protocol HomeViewRepo {
    func createNewComponent(componentsType: ComponentsType) throws
    
    func observeComponents(completion: @escaping (Result<[ComponentsType], Error>) -> Void)
    
    func deleteComponent(componentId: String, completion: @escaping (Result<Void, Error>) -> Void)
    
    func updateComponent(componentsType: ComponentsType) throws 
}
