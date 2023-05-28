//
//  String + Date.swift
//  KingsTestApp
//
//  Created by Arcani on 26.05.2023.
//

import Foundation

extension String {
    func formattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormatter.date(from: self) {
            let readableDateFormatter = DateFormatter()
            readableDateFormatter.dateFormat = "MMM d, yyyy"

            return readableDateFormatter.string(from: date)
        } else {
            return "Invalid date string"
        }
    }
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
}
