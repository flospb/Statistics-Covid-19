//
//  UserDefaultsServiceMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 12.09.2021.
//

import Foundation

final class UserDefaultsMock: UserDefaults {
    var value: Any?
    var key: String?
    var transmittedValueSet = false
    var transmittedValueReceived = false

    override func setValue(_ value: Any?, forKey key: String) {
        self.value = value
        self.key = key
        transmittedValueSet = true
    }

    override func data(forKey key: String) -> Data? {
        transmittedValueReceived = true
        self.key = key
        return value as? Data
    }
}
