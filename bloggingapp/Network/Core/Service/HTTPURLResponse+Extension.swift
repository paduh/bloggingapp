//
//  HTTPURLResponse+Extension.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - HTTPURLResponse Extension

extension HTTPURLResponse {

    func handleNetworkResponse() -> Result<String> {
        switch self.statusCode {
        case 200...299, 422, 400: return .success
        case 401: return .success
        case 403: return .failure(NetworkResponse.badRequest.title)
        case 402...499: return .failure(NetworkResponse.authenticationError.title)
        case 500...599: return .failure(NetworkResponse.badRequest.title)
        case 600: return .failure(NetworkResponse.outdated.title)
        case 1001: return .failure(NetworkResponse.noNetworkConnection.title)
        case 999: return .failure(NetworkResponse.noNetworkConnection.title)
        default: return .failure(NetworkResponse.failed.title)
        }
    }

    // MARK: - Result

    enum Result<String> {
        case success
        case failure(String)
    }
}
