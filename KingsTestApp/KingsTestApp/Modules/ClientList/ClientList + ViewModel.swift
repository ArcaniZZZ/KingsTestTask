//
//  ClientList + ViewModel.swift
//  KingsTestApp
//
//  Created by Arcani on 25.05.2023.
//

import Foundation

extension ClientList {
    final class ClientListViewModel: ObservableObject {
        
        // MARK: - Properties
        
        @Published var displayedClients = [Client]()
        @Published var searchScope: SearchCategory = .fullName
        @Published var searchText: String = "" {
            didSet { filterClientsBasedOnSearchField() }
        }
        
        @Published var dateFilter = Date() {
            didSet { didChangeDate() }
        }
        @Published var statusFilter = ClientStatus.all {
            didSet { didChangeFilter() }
        }
        
        private(set) var clients = [Client]()
        private lazy var dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return dateFormatter
        }()
        

        // MARK: - Dependencies
                
        private let clientService: ClientService
        
        
        // MARK: - Init
        
        init() {
            clientService = ServiceFactory.shared.clientsService
            clients = fetchClients()
            displayedClients = clients
        }
        
        
        // MARK: - Private Methods
        
        private func didChangeFilter() {
            displayedClients = clients
            displayedClients = displayedClients.filter { client in
                guard statusFilter != .all else { return true }
                return client.fullStatus.statusCode == statusFilter.rawValue
            }
        }
        
        private func didChangeDate() {
            displayedClients = clients
            displayedClients = displayedClients.filter { client in
                guard let clientCreatedDate = dateFormatter.date(from: client.created ?? "") else { return false }
                return clientCreatedDate <= dateFilter
            }
        }
        
        private func filterClientsBasedOnSearchField() {
            displayedClients = clients.filter { client in
                guard !searchText.isEmpty else { return true }
                let lowercasedSearchText = searchText.lowercased()
                
                switch searchScope {
                case .fullName:
                    return (client.fullName.lowercased().contains(lowercasedSearchText))
                case .phone:
                    return (client.fixedLinePhone?.contains(lowercasedSearchText) ?? false)
                case .mobilePhone:
                    return (client.mobilePhone?.contains(lowercasedSearchText) ?? false)
                case .email:
                    return (client.email?.contains(lowercasedSearchText) ?? false)
                case .company:
                    return (client.clientOrganisation?.name.lowercased().contains(lowercasedSearchText) ?? false)
                }
            }
        }
        
        private func fetchClients() -> [Client] {
            clientService.fetchClients()
        }
    }
}
