//
//  RequestSender.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

protocol IRequestSender {
    func send<Parser>(configuration: RequestConfiguration<Parser>, completionHandler: @escaping (Result<Parser.Model, NetworkServiceError>) -> Void)
}

class RequestSender: IRequestSender {
    private let session = URLSession.shared
    
    func send<Parser>(configuration: RequestConfiguration<Parser>, completionHandler: @escaping (Result<Parser.Model, NetworkServiceError>) -> Void) {
        guard let urlRequest = configuration.request.urlRequest else {
            completionHandler(.failure(.incorrectUrl))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { (data: Data?, _, error: Error?) in
            if error != nil {
                completionHandler(.failure(.networking))
            }
            
            guard let data = data, let parsedModel: Parser.Model = configuration.parser.parse(data: data) else {
                completionHandler(.failure(.decoding))
                return
            }
            
            completionHandler(.success(parsedModel))
        }
        
        task.resume()
    }
}
