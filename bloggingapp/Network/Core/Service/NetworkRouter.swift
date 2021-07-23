//
//  NetworkRouter.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - Network Router

public protocol NetworkRouter {

    associatedtype EndPoint: EndPointType
    associatedtype Model: Codable

    typealias NetworkRouterCompletion = ((Result<Model>) -> Void)

    func request(route: EndPoint, logContent: Bool, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

// MARK: - Generic Network Router Result

public enum Result<T: Codable> {
    case success(_ data: T)
    case failure(_ error: NetworkResponse)
}
