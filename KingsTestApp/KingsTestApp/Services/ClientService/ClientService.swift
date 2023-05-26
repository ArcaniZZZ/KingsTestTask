//
//  ClientService.swift
//  KingsTestApp
//
//  Created by Arcani on 25.05.2023.
//

import Foundation

final class ClientService {
    
    // MARK: - Public Methods
    
    public func fetchClients() -> [Client] {
        guard let data = fetchJSON(),
              let clients = decodeJSON(from: data, to: Clients.self)
        else {
            return []
        }

        return clients.data
    }
    
    
    // MARK: - Private Methods
    
    private func decodeJSON<T: Decodable>(from data: Data, to model: T.Type) -> T? {
        let decoder = JSONDecoder()
        let decodedResponse = try? decoder.decode(model, from: data)
        return decodedResponse
    }
    
    private func fetchJSON() -> Data? {
        guard let path = Bundle.main.path(forResource: "MockJSON", ofType: "json") else {
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            return jsonData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
