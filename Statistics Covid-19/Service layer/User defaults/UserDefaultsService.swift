//
//  UserDefaultsService.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

// TODO need for asynchron

protocol IUserDefaultsService {
    func saveObject<T: Encodable>(object: T, for key: String)
    func getObject<T: Decodable>(for key: String) -> T?
}

final class UserDefaultsService: IUserDefaultsService {

    // MARK: - Dependencies
    
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

    // MARK: - IUserDefaultsService
    
    func saveObject<T: Encodable>(object: T, for key: String) { // todo need to try? in one row
        do {
            let data = try encoder.encode(object)
            defaults.setValue(data, forKey: key)
        } catch {
            return
        }
    }

    func getObject<T: Decodable>(for key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        do {
            let data = try decoder.decode(T.self, from: data)
            return data
        } catch {
            return nil
        }
    }
}
