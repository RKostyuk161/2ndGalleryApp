//
//  DateFormatter.swift
//  2ndGalleryApp
//
//  Created by Роман on 04.08.2021.
//

import Foundation

class HumanDateFormatter {
    static var currentUsersDate: String?
    
    static func humanityDateConverter(date: String) -> String {
        let apiFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let humanFormat = "d MMM, yyyy"
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = apiFormat
        guard let date = inputDateFormatter.date(from: date) else { return ""}
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = humanFormat
        return outputDateFormatter.string(from: date)
    }
}
