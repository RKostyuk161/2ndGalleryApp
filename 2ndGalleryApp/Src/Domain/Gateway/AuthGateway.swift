//
//  AuthGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 25.06.2021.
//

import Foundation
import RxSwift

protocol AuthGateway {
    
    func auth(username: String, password: String) -> Single<TokenEntity>
    
    func refreshToken(refreshToken: String) -> Single<TokenEntity>
}
