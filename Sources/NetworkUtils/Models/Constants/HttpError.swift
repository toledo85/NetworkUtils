//
//  HttpError.swift
//  TodoIt
//
//  Created by Jorge Luis Toledo on 6/17/23.
//

import Foundation

public enum HttpError: Error {
    case basURL
    case badResponse
    case errorDecodingData
    case invalidURL
}
