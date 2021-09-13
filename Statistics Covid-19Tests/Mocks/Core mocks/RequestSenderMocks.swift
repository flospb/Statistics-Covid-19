//
//  RequestSenderMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 12.09.2021.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var error: Error?

    override func dataTask(with: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}

class RequestMock: IRequest {
    var urlRequest: URLRequest?

    init(url: URL) {
        self.urlRequest = URLRequest(url: url)
    }
}

class ParserMock: IParser {
    typealias Model = Data

    var data: Data

    init(data: Data) {
        self.data = data
    }

    func parse(data: Data) -> Data? {
        return data
    }
}
