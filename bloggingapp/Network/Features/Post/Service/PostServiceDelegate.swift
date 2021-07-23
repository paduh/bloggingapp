//
//  PostServiceDelegate.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

typealias PostCompletion = ((Result<[Post]?>) -> Void)
typealias CommentCompletion = ((Result<[Comment]?>) -> Void)

// MARK: - PostServiceDelegate

protocol PostServiceDelegate: class {

    func fetchComments(postId: Int, completion: @escaping CommentCompletion)
    func fetchPosts(completion: @escaping PostCompletion)
}
