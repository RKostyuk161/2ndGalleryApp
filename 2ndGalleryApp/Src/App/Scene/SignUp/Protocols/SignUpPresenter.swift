//
//  SignUpPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 29.06.2021.
//

import UIKit
import Foundation

protocol SignUpPresenter {
    func openSignInScene()
    func signUp(user: SignUpEntity)
    func getUser() -> UserEntity?
}
