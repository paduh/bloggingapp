//
//  PostServiceDelegate.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

typealias PostCompletion = ((Result<[Post]?>)->())
typealias CommentCompletion = ((Result<[Comment]?>)->())

// MARK: - PostServiceDelegate

protocol PostServiceDelegate {
            
    func fetchComments(id: Int, completion: @escaping CommentCompletion)
    func fetchPosts(completion: @escaping PostCompletion)
}
