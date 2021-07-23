//
//  URLParameterEncoder.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - URLParameterEncoder

struct URLParameterEncoder: ParameterEncoder {
    var acceptHeader: String? {
        urlRequest?.value(forHTTPHeaderField: "Accept")
    }

    var contentTypeHeader: String? {
        (urlRequest?.value(forHTTPHeaderField: "Content-Type"))
    }
    var urlRequest: URLRequest?

    init(urlRequest: inout URLRequest) {
        self.urlRequest = urlRequest
    }

    func encode(with parameters: Parameters) throws {
        var urlRequest = self.urlRequest
        guard let url = urlRequest?.url else { throw NetworkError.missingURL}
        if var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {

            urlComponent.queryItems = [URLQueryItem]()

            for (key, value) in parameters {
            let queryItem = URLQueryItem(
                name: key,
                value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponent.queryItems?.append(queryItem)
            }
            urlRequest?.url = urlComponent.url
        }

        if acceptHeader == nil || contentTypeHeader != nil {
            urlRequest?.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            urlRequest?.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Accept")
        }
    }
}
