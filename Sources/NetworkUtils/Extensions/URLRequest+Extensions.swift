//
//  URLRequest+Extensions.swift
//
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

extension URLRequest {
    mutating func signRequest(with token: String) {
        set(jsonWebToken: token)
    }
    
    mutating func set(jsonWebToken token: String) {
        set(header: .authorization, value: token)
    }
    
    mutating func set(method: HttpMethods) {
        httpMethod = method.rawValue
    }
    
    mutating func set(header: HttpHeaders, value: String) {
        addValue(value, forHTTPHeaderField: header.rawValue)
    }
    
    public static func createRequest(from url: String) throws -> URLRequest {
        let url = try URL.createUrl(stringUrl: url)
        return URLRequest(url: url)
    }
}
