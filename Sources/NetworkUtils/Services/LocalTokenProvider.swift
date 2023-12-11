//
//  LocalTokenProvider.swift
//
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

public struct LocalTokenProvider: TokenProvider {
    public init() {}
    
    public func getToken() throws -> AuthTokenModelDto {
        guard let token = UserDefaults.standard.string(forKey: "bearerToken") else {
            throw TokenError.unavailableLocalToken
        }
        
        return AuthTokenModelDto(accessToken: token)
    }
}
