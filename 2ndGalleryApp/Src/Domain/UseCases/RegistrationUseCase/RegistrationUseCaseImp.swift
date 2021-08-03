//
//  RegistrationApiUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 29.06.2021.
//

import Foundation
import RxSwift

class RegistrationUseCaseImp: RegistrationUseCase {
    
    let registrationGateway: RegistrationGateway
    
    init(registrationGateway: RegistrationGateway) {
        self.registrationGateway = registrationGateway
    }
    
    func signUp(entity: SignUpEntity) -> Single<UserEntity> {
        return registrationGateway.signUp(entity: entity)
    }
}
