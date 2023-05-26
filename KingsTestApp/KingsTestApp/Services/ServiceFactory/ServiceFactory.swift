//
//  ServiceFactory.swift
//  KingsTestApp
//
//  Created by Arcani on 25.05.2023.
//

import Foundation

final class ServiceFactory {
    
    // MARK: - Properties
    
    static let shared = ServiceFactory()
    lazy var clientsService = ClientService()
    
    
    // MARK: - Init
    
    private init() {}
}
