//
//  JSONParameterEncoder.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - JSONParameterEncoder

struct JSONParameterEncoder: ParameterEncoder {
    var acceptHeader: String? {
        urlRequest?.value(forHTTPHeaderField: "Accept")
    }

    var contentTypeHeader: String? {
        (urlRequest?.value(forHTTPHeaderField: "Content-Type"))
    }

    init(urlRequest: inout URLRequest) {
        self.urlRequest = urlRequest
    }

    var urlRequest: URLRequest?

    func encode(with parameters: Parameters) throws {
        var urlRequest = self.urlRequest
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest?.httpBody = jsonData
            if acceptHeader == nil || contentTypeHeader != nil {
                urlRequest?.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest?.setValue("application/json", forHTTPHeaderField: "Accept")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
