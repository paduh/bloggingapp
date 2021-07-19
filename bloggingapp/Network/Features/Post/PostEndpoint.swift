//
//  PostEndpoint.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - PostEndpoint

enum PostEndpoint {
    case posts
}

// MARK: - EndPointType

extension PostEndpoint: EndPointType {
    
    var baseUrl: URL {
        return URL(string: Constant.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .posts:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .posts:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }
}
