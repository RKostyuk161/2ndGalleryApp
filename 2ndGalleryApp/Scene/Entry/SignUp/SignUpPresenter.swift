//
//  SignUpPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 29.06.2021.
//

import Foundation

protocol SignUpPresenter {
        
    func signUp(user: SignUpEntity)
    
    func getUser() -> UserEntity?
    
    func proceed(user: SignUpEntity)
}
