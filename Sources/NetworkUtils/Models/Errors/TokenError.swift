//
//  TokenError.swift
//  
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

enum TokenError: String, Error {
    case unavailableToken = "Unable to token."
    case unavailableLocalToken = "There is no token in Local Storage."
}
