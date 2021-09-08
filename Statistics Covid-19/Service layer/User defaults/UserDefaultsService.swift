//
//  UserDefaultsService.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

protocol IUserDefaultsService {
    func saveObject<T: Encodable>(object: T, for key: String)
    func getObject<T: Decodable>(for key: String) -> T?
}

final class UserDefaultsService: IUserDefaultsService {

    // MARK: - Dependencies

    private let defaults: UserDefaults

    // MARK: - Initialization

    init(userDefaults: UserDefaults) {
        self.defaults = userDefaults
    }

    convenience init() {
        self.init(userDefaults: UserDefaults.standard)
    }

    // MARK: - IUserDefaultsService

    func saveObject<T: Encodable>(object: T, for key: String) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        defaults.setValue(data, forKey: key)
    }

    func getObject<T: Decodable>(for key: String) -> T? {
        guard let data = defaults.data(forKey: key),
              let result = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return result
    }
}
