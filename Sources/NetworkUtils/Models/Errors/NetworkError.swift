//
//  NetworkError.swift
//  
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

public enum NetworkError: String, Error {
    case invalidUrl = "The URL is invalid."
    case invalidResponse = "Invalid response from the server."
    case unableToComplete = "Unable to complete your request."
}
