//
//  PostService.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - PostService

class PostService<T: Codable>: PostServiceDelegate {

    // MARK: Properties

    var postRouter: Router<PostEndpoint, [Post]>
    var commentRouter: Router<PostEndpoint, [Comment]>

    // MARK: Initialiser / DeInitializer

    init(
        postRouter: Router<PostEndpoint, [Post]> = Router<PostEndpoint, [Post]>(),
        commentRouter: Router<PostEndpoint, [Comment]> = Router<PostEndpoint, [Comment]>()
       ) {
        self.postRouter = postRouter
        self.commentRouter = commentRouter
    }
}

// MARK: - PostService & PostServiceDelegate

extension PostService {

    func fetchPosts(completion: @escaping PostCompletion) {
        postRouter.request(route: .posts, completion: completion)
    }

    func fetchComments(postId: Int, completion: @escaping CommentCompletion) {
        commentRouter.request(route: .postComments(postId: postId), completion: completion)
    }
}
