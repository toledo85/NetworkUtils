//
//  URL+Extensions.swift
//
//
//  Created by Jorge Luis Toledo on 12/10/23.
//

import Foundation

extension URL {
    public static func createUrl(stringUrl: String) throws -> URL {
        guard let url = URL(string: stringUrl) else {
            throw NetworkError.invalidUrl
        }
        
        return url
    }
}
