//
//  AuthUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation
import RxSwift

protocol AuthUseCase {
    var tokenState: TokenState { get }
    
    func sighIn(login: String, password: String) -> Completable
    
    func refreshToken() -> Completable
    
    func logout()
}
