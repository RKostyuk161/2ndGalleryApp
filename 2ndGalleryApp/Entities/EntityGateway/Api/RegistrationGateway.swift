//
//  RegistrationGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 29.06.2021.
//

import Foundation
import RxSwift

protocol RegistrationGateway {
    
    func signUp(entity: SignUpEntity, locale: String) -> Single<UserEntity>
    
}
