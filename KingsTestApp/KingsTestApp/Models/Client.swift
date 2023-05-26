//
//  Client.swift
//  KingsTestApp
//
//  Created by Arcani on 25.05.2023.
//

struct Client: Decodable, Identifiable, Hashable {

    // MARK: Properties
    
    let id: String
    let firstName: String?
    let lastName: String?
    let created: String?
    let clientOrganisation: ClientOrganisation?
    let fullStatus: FullStatus
    let fixedLinePhone: String?
    let mobilePhone: String?
    let email: String?
    
    var fullName: String {
        return Client.getFullName(firstName: self.firstName, lastName: self.lastName)
    }
    
    
    // MARK: - Public Methods
    
    static func getFullName(firstName: String?, lastName: String?) -> String {
        let firstName = firstName ?? ""
        let lastName = lastName ?? ""
        return firstName + " " + lastName
    }
}
