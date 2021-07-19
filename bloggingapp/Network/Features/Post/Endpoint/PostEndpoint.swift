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
    case postComments(id: Int)
}

// MARK: - EndPointType

extension PostEndpoint: EndPointType {
    
    var baseUrl: URL {
        return URL(string: Constant.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .posts:
            return Constant.posts
        case .postComments:
            return Constant.comments
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .posts, .postComments:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .posts:
            return .request
        case .postComments(let id):
            let param: [String: Int] = [
                "postId": id
            ]
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: param)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }
}
