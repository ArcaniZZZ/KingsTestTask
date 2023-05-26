//
//  Enums.swift
//  KingsTestApp
//
//  Created by Arcani on 26.05.2023.
//

import Foundation

enum SearchCategory {
    case fullName
    case phone
    case mobilePhone
    case email
    case company
}

enum ClientStatus: String {
    case all = "All"
    case ready = "S1"
    case inProgress = "S2"
}
