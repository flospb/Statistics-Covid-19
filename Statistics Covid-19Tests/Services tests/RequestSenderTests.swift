//
//  RequestSenderTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 12.09.2021.
//

import XCTest
@testable import Statistics_Covid_19

class RequestSenderTest: XCTestCase {
    var sut: IRequestSender!
    var session: URLSessionMock!
    var request: RequestMock!
    var parser: ParserMock!
    var result: Result<ParserMock.Model, NetworkingError>!

    let data = Data([1])
    let error = NetworkingError.networking

    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        request = RequestMock(url: URL(fileURLWithPath: "testUrl"))
        parser = ParserMock(data: data)
        sut = RequestSender(session: session)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        session = nil
        request = nil
        parser = nil
        result = nil
    }

    func testThatCheckSuccessResponse() {
        // arrange
        let didReceiveResponse = expectation(description: #function)
        let configuration = Configuration(request: request, parser: parser)
        session.data = data

        // act
        sut.send(configuration: configuration) {
            self.result = $0
            didReceiveResponse.fulfill()
        }

        // assert
        wait(for: [didReceiveResponse], timeout: 3)
        XCTAssertEqual(result, .success(data))
    }

    func testThatCheckFailureResponse() {
        // arrange
        let didReceiveResponse = expectation(description: #function)
        let configuration = Configuration(request: request, parser: parser)
        session.error = error

        // act
        sut.send(configuration: configuration) {
            self.result = $0
            didReceiveResponse.fulfill()
        }

        // assert
        wait(for: [didReceiveResponse], timeout: 3)
        XCTAssertEqual(result, .failure(error))
    }
}
