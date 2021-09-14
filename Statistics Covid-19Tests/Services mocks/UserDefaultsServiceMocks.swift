//
//  UserDefaultsServiceMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 12.09.2021.
//

import Foundation

class UserDefaultsMock: UserDefaults {
    var value: Any?
    var key: String?
    var transmittedValueSet = false
    var transmittedValueReceived = false

    override func setValue(_ value: Any?, forKey key: String) {
        transmittedValueSet = true
        self.value = value
        self.key = key
    }

    override func data(forKey key: String) -> Data? {
        transmittedValueReceived = true
        self.key = key
        return value as? Data
    }
}

class UserDefaultsServiceMock: IUserDefaultsService {
    func saveObject<T>(object: T, for key: String) where T: Encodable {}
    func getObject<T>(for key: String) -> T? where T: Decodable {
        return nil
    }
}
