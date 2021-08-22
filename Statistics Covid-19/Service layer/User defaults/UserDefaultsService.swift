//
//  UserDefaultsService.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

// TODO change

protocol IUserDefaultsService {
    func saveObject<T: Encodable>(object: T, for key: String)
    func getObject<T: Decodable>(for key: String) -> T?
}

final class UserDefaultsService: IUserDefaultsService {
    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Initialization
    
    init(userDefaults: UserDefaults) {
        self.defaults = userDefaults
    }

    convenience init() {
        self.init(userDefaults: UserDefaults.standard)
    }

    // MARK: - Working with data
    
    func saveObject<T: Encodable>(object: T, for key: String) {
        // TODO change to do catch
        guard let data = try? encoder.encode(object) else {
            return
        }
        defaults.setValue(data, forKey: key)
    }

    func getObject<T: Decodable>(for key: String) -> T? {
        guard let data = defaults.data(forKey: key) else {
            return nil
        }
        return try? decoder.decode(T.self, from: data)
    }
}
