//
//  RequestSender.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

protocol IRequestSender {
    func send<Parser>(configuration: Configuration<Parser>, completion: @escaping (Result<Parser.Model, NetworkServiceError>) -> Void)
}

class RequestSender: IRequestSender {

    // MARK: - Models

    private let session = URLSession.shared

    // MARK: - IRequestSender

    func send<Parser>(configuration: Configuration<Parser>,
                      completion: @escaping (Result<Parser.Model, NetworkServiceError>) -> Void) {
        guard let urlRequest = configuration.request.urlRequest else {
            completion(.failure(.incorrectUrl))
            return
        }

        let task = session.dataTask(with: urlRequest) { (data: Data?, _, error: Error?) in
            if error != nil {
                completion(.failure(.networking))
                return
            }

            guard let data = data, let parsedModel: Parser.Model = configuration.parser.parse(data: data) else {
                completion(.failure(.decoding))
                return
            }

            completion(.success(parsedModel))
        }

        task.resume()
    }
}
