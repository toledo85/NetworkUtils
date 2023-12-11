//
//  NetworkSession.swift
//  
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

public protocol HttpClient {
    func perform(from request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    func perform(from request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
