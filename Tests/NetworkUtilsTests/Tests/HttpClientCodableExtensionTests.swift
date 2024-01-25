//
//  HttpClientDecodableExtensionTests.swift
//  
//
//  Created by Jorge Luis Toledo on 12/10/23.
//

import XCTest
@testable import NetworkUtils

class HttpClientCodableExtensionTests: XCTestCase {
    func testGetFromJsonWithRequestSuccess() async throws {
        let dummy = Dummy()
        let expectedData = try JSONEncoder().encode(dummy)
        let expectedResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mockClient = MockHttpClient(expectedResult: .success((expectedData, expectedResponse)))

        do {
            let result: Dummy = try await mockClient.getFromJson(to: URLRequest(url: URL(string: "https://example.com")!))
            XCTAssertEqual(result.message, dummy.message)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetFromJsonWithRequestFailure() async {
        let expectedError = NetworkError.invalidResponse
        let mockClient = MockHttpClient(expectedResult: .failure(expectedError))
        
        do {
            let _: Dummy = try await mockClient.getFromJson(to: "https://example.com")
            XCTFail("Expected failure, got success")
        } catch let error as NetworkError {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    class Dummy: Codable {
        var message = "Hello, World!"
    }
}
