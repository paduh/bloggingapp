//
//  PostService.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - PostService

class PostService: PostServiceDelegate {
    
    // MARK: Properties

    var router: Router<PostEndpoint, [Post]>

    // MARK: Initialiser / DeInitializer

    init(
        router: Router<PostEndpoint, [Post]> = Router<PostEndpoint, [Post]>()
       ) {
        self.router = router
    }
}

// MARK: - PostService & PostServiceDelegate

extension PostService {
    func fetchPosts(completion: @escaping PostCompletion) {
        router.request(route: .posts, completion: completion)
    }
}
