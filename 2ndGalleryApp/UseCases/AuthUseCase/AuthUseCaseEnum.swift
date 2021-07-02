//
//  AuthUseCaseEnum.swift
//  2ndGalleryApp
//
//  Created by Роман on 24.06.2021.
//

import Foundation

enum TokenState {
    case active
    case refreshing
    case failedToRefresh
    case none
}
