//
//  DecodableMethods.swift
//
//
//  Created by Jorge Luis Toledo on 12/9/23.
//

import Foundation

extension HttpClient {
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func getFromJson<T: Decodable>(
        to request: URLRequest,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let (data, _) = try await perform(from: request)

        guard let object = try? decoder.decode(T.self, from: data) else {
            throw HttpError.errorDecodingData
        }
        
        return object
    }
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func getFromJson<T: Decodable>(
        to url: String,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let request = try URLRequest.createRequest(from: url)
        return try await getFromJson(to: request, decoder: decoder)
    }
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func postAsJson(
        to request: URLRequest,
        object: some Encodable,
        encoder: JSONEncoder = JSONEncoder()
    ) async throws -> (Data, HTTPURLResponse) {
        var request = request
        request.set(method: .post)
        request.set(header: .contentType, value: MimeType.json.rawValue)
        request.httpBody = try encoder.encode(object)
                
        return try await perform(from: request)
    }
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func postAsJson(
        to url: String,
        object: (some Encodable)? = nil,
        encoder: JSONEncoder = JSONEncoder()
    ) async throws -> (Data, HTTPURLResponse) {
        let request = try URLRequest.createRequest(from: url)
        return try await postAsJson(to: request, object: object, encoder: encoder)
    }
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func put(
        to request: URLRequest,
        object: some Encodable,
        encoder: JSONEncoder = JSONEncoder()
    ) async throws -> (Data, HTTPURLResponse) {
        var request = request
        request.set(method: .put)
        request.set(header: .contentType, value: MimeType.json.rawValue)
        request.httpBody = try encoder.encode(object)
        
        return try await perform(from: request)
    }
    
    @available(iOS 13.0.0, macOS 10.15.0, *)
    public func put(
        to url: String,
        object: some Encodable,
        encoder: JSONEncoder = JSONEncoder()
    ) async throws -> (Data, HTTPURLResponse) {
        let request = try URLRequest.createRequest(from: url)
        return try await put(to: request, object: object, encoder: encoder)
    }
}
