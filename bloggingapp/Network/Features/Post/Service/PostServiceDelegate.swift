//
//  PostServiceDelegate.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

typealias PostCompletion = ((Result<[Post]?>)->())

// MARK: - PostServiceDelegate

protocol PostServiceDelegate {
    
    var router: Router<PostEndpoint, [Post]> { get set }
    
    func fetchPosts(completion: @escaping PostCompletion)
    
}
