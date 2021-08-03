//
//  Ыуеештпы.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation

protocol Settings: AnyObject {
    
    var token: TokenEntity? { get set }
    var account: UserEntity? { get set }
    
    func clearUserData()
}
