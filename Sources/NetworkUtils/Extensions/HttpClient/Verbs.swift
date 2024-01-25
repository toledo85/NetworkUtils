//
//  Verbs.swift
//  
//
//  Created by Jorge Luis Toledo on 1/25/24.
//

import Foundation

extension HttpClient {    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func delete(to request: URLRequest) async throws {
        var request = request
        request.set(method: .delete)
        
        _ = try await perform(from: request)
    }
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func delete(to url: String) async throws {
        let request = try URLRequest.createRequest(from: url)
        return try await delete(to: request)
    }
}
