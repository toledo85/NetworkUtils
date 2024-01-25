//
//  Default.swift
//  
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

extension HttpClient {
    public func perform(from request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unableToComplete))
                return
            }
            
            completion(.success((data, response)))
        }).resume()
    }
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func perform(from request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
                (200..<300) ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        return (data, response)
    }
}
