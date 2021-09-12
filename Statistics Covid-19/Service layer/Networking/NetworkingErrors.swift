//
//  NetworkingErrors.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 12.09.2021.
//

import Foundation

// MARK: - Errors

enum NetworkingError: Error {
    case incorrectUrl
    case networking
    case decoding
    case unknown

    var message: String {
        switch self {
        case .incorrectUrl:
            return "Использован некорректный URL. Повторите попытку позже."
        case .networking:
            return "Ошибка соединения. Повторите попытку позже."
        case .decoding:
            return "Ошибка получения данных. Повторите попытку позже."
        case .unknown:
            return "Неизвестная ошибка. Повторите попытку позже."
        }
    }
}
