//
//  TokenProvider.swift
//  
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

public protocol TokenProvider {
    func getToken() throws -> AuthTokenModelDto
}
