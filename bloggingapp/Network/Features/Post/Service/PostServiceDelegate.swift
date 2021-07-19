//
//  PostServiceDelegate.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

typealias PostCompletion<Model:Codable> = ((Result<Model?>)->())

// MARK: - PostServiceDelegate

protocol PostServiceDelegate {
    
    associatedtype Model: Codable
    
    var router: Router<PostEndpoint, Model> { get set }
    
    func fetchPosts(completion: @escaping PostCompletion<Model>)
    
}
