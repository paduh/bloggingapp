//
//  HTTPMethod.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - HTTPMethod

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    
    var title: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        }
    }
}
