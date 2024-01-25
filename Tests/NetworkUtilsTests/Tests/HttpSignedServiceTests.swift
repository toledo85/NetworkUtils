//
//  HttpClientDecodableExtensionTests.swift
//  
//
//  Created by Jorge Luis Toledo on 12/10/23.
//

import XCTest
@testable import NetworkUtils

class HttpSignedServiceTests: XCTestCase {
    func testCallbackBasedPerformSuccess() {
        let expectedData = Data("Mock data".utf8)
        let expectedResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mockClient = MockHttpClient(expectedResult: .success((expectedData, expectedResponse)))
        let tokenProvider = MockTokenProvider()
        let httpClient = HttpSignedService(client: mockClient, tokenProvider: tokenProvider)
        
        let expectation = XCTestExpectation(description: "Callback-based perform expectation")
        
        httpClient.perform(from: URLRequest(url: URL(string: "https://example.com")!)) { [expectedData, expectedResponse] result in
            switch result {
            case .success(let (data, response)):
                XCTAssertEqual(data, expectedData)
                XCTAssertEqual(response, expectedResponse)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCallbackBasedPerformFailure() {
        let expectedError = NetworkError.invalidResponse
        let mockClient = MockHttpClient(expectedResult: .failure(expectedError))
        let tokenProvider = MockTokenProvider()
        let httpClient = HttpSignedService(client: mockClient, tokenProvider: tokenProvider)
        
        let expectation = XCTestExpectation(description: "Callback-based perform expectation")

        httpClient.perform(from: URLRequest(url: URL(string: "https://example.com")!)) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, expectedError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testAsyncBasedPerformSuccess() async {
        let expectedData = Data("Mock data".utf8)
        let expectedResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mockClient = MockHttpClient(expectedResult: .success((expectedData, expectedResponse)))
        let tokenProvider = MockTokenProvider()
        let httpClient = HttpSignedService(client: mockClient, tokenProvider: tokenProvider)
        
        do {
            let (data, response) = try await httpClient.perform(from: URLRequest(url: URL(string: "https://example.com")!))
            XCTAssertEqual(data, expectedData)
            XCTAssertEqual(response, expectedResponse)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testAsyncBasedPerformFailure() async {
        let expectedError = NetworkError.invalidResponse
        let mockClient = MockHttpClient(expectedResult: .failure(expectedError))
        let tokenProvider = MockTokenProvider()
        let httpClient = HttpSignedService(client: mockClient, tokenProvider: tokenProvider)
        
        do {
            _ = try await httpClient.perform(from: URLRequest(url: URL(string: "https://example.com")!))
            XCTFail("Expected failure, got success")
        } catch let error as NetworkError {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    class MockTokenProvider: TokenProvider {
        func getToken() throws -> NetworkUtils.AuthTokenModelDto {
            .init(accessToken: "Super secret token")
        }
    }
}
