//
//  LocalSettings.swift
//  2ndGalleryApp
//
//  Created by Роман on 06.07.2021.
//

import Foundation

class LocalSettings: Settings {
    
    
    var token: TokenEntity? {
        get {
            return self.userDefaults.read(UserDefaultsKey.token)
        }
        set(value) {
            return self.userDefaults.saveData(UserDefaultsKey.token, value)
        }
    }
    
    var account: UserEntity? {
        get {
            return self.userDefaults.read(UserDefaultsKey.account)
        }
        set(value) {
            return self.userDefaults.saveData(UserDefaultsKey.account, value)
        }
    }
    
    var defaultSuitName: String? {
        get {
            return self.userDefaults.read(UserDefaultsKey.defautSiutname)
        }
        set(value) {
            return self.userDefaults.saveData(UserDefaultsKey.defautSiutname, value)
        }
    }
    
    let userDefaults: UserDefaultsSettings
    
    init(userDefaults: UserDefaultsSettings) {
        self.userDefaults = userDefaults
    }
    
    
    func clearUserData() {
        self.token = nil
        self.account = nil
        self.userDefaults.resetUserDefaults()
    }
    
    
}
