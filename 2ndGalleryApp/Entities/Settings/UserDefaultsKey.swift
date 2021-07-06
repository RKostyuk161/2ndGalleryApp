//
//  UserDefaultsKey.swift
//  2ndGalleryApp
//
//  Created by Роман on 06.07.2021.
//

import Foundation

protocol UserDefaultsKeyType {
    var rawValue: String { get }
    
}

enum UserDefaultsKey: String, CaseIterable ,UserDefaultsKeyType {
    
    case token,
         account,
         accountsUsername
    
    static var clearable: [UserDefaultsKey] {
        return UserDefaultsKey.allCases
    }
}
