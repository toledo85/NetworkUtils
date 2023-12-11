//
//  AuthHttpService.swift
//
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

public class HttpSignedService: HttpClient {
    let client: HttpClient
    let tokenProvider: TokenProvider
    
    public init(client: HttpClient = URLSession.shared, tokenProvider: TokenProvider) {
        self.client = client
        self.tokenProvider = tokenProvider
    }
    
    public func perform(from request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        do {
            let token = try tokenProvider.getToken().accessToken
            var request = request
            request.signRequest(with: token)
            client.perform(from: request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func perform(from request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let token = try tokenProvider.getToken().accessToken
        var signedRequest = request
        signedRequest.signRequest(with: token)
        return try await client.perform(from: signedRequest)
    }
}
