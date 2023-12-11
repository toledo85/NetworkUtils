//
//  MockHttpClient.swift
//  
//
//  Created by Jorge Luis Toledo on 12/10/23.
//

import Foundation
@testable import NetworkUtils

class MockHttpClient: HttpClient {
    var expectedResult: Result<(Data, HTTPURLResponse), Error>
    
    init(expectedResult: Result<(Data, HTTPURLResponse), Error>) {
        self.expectedResult = expectedResult
    }
    
    func perform(from request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        completion(expectedResult)
    }
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    func perform(from request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        switch expectedResult {
        case .success(let result):
            return result
        case .failure(let error):
            throw error
        }
    }
}
