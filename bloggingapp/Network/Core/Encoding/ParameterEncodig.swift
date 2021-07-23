//
//  ParameterEncodig.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - Parameters Typealias

public typealias Parameters = [String: Any]

// MARK: - ParameterEncoder

public protocol ParameterEncoder {
    var acceptHeader: String? { get }
    var contentTypeHeader: String? { get }

    func encode(with parameters: Parameters) throws
}

// MARK: - ParameterEncoding

public enum ParameterEncoding {

    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    // Case multipartForm

    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder(urlRequest: &urlRequest).encode(with: urlParameters)

            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder(urlRequest: &urlRequest).encode(with: bodyParameters)

            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder(urlRequest: &urlRequest).encode(with: urlParameters)
                try JSONParameterEncoder(urlRequest: &urlRequest).encode(with: bodyParameters)

            }
        } catch {
            throw error
        }
    }
}

// MARK: - NetworkError

enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
