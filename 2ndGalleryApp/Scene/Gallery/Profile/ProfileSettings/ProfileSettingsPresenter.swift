//
//  ProfileSettingsPresenter.swift
//  2ndGalleryApp
//
//  Created by Роман on 12.07.2021.
//

import Foundation
import UIKit

protocol ProfileSettingsPresenter {
    
    var settings: Settings { get }
    
    func saveSettings()
    func updatePhoto(image: UIImage)
    
}
