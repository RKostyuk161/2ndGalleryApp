//
//  SignInPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import Foundation

protocol SignInPresenter {
    func signIn(username: String, password: String)
    func openSignUpScene()
}
