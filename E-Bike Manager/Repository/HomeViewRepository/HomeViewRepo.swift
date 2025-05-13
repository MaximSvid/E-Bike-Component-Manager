//
//  HomeViewRepo.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 13.05.25.
//

protocol HomeViewRepo {
    func createNewComponent(components: Component) throws
    
    func observeComponents(completion: @escaping (Result<[Component], Error>) -> Void)
    
    func deleteComponent(componentId: String, completion: @escaping (Result<Void, Error>) -> Void)
    
    func updateComponent(components: Component) throws
}
