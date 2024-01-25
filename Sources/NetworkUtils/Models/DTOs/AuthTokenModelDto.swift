//
//  AuthTokenModelDto.swift
//  
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

public struct AuthTokenModelDto: Codable {
    let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
