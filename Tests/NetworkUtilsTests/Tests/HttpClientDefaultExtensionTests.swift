//
//  File.swift
//  
//
//  Created by Jorge Luis Toledo on 12/11/23.
//

import XCTest
@testable import NetworkUtils

class HttpClientDefaultExtensionTests: XCTestCase {
    override class func setUp() {
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    override class func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
    }
    
    func testCallbackBasedPerformSuccess() {
        let request = URLRequest(url: URL(string: "https://example.com")!)
        let expectedData = "Mocked data".data(using: .utf8)!
        let expectedResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let expectation = XCTestExpectation(description: "Callback-based perform expectation")
        
        MockURLProtocol.requestHandler = { request in
            return (expectedResponse, expectedData)
        }
        
        URLSession.shared.perform(from: request) { result in
            switch result {
            case .success(let (data, _)):
                XCTAssertEqual(data, expectedData)
                // XCTAssertEqual(response, expectedResponse)
            case .failure:
                XCTFail("Expected success, got failure")
            }

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
