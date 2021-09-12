//
//  RequestSender.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

protocol IRequest {
    var urlRequest: URLRequest? { get }
}

protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}

struct Configuration<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}

protocol IRequestSender {
    func send<Parser>(configuration: Configuration<Parser>, completion: @escaping (Result<Parser.Model, NetworkingError>) -> Void)
}

class RequestSender: IRequestSender {

    // MARK: - Dependencies

    private let session: URLSession

    // MARK: - Initialization

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    // MARK: - IRequestSender

    func send<Parser>(configuration: Configuration<Parser>,
                      completion: @escaping (Result<Parser.Model, NetworkingError>) -> Void) {
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
