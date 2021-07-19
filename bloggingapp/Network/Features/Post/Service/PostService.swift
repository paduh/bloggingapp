//
//  PostService.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - PostService

class PostService<Model: Codable>: PostServiceDelegate {
    
    // MARK: Properties

    var router: Router<PostEndpoint, Model>

    // MARK: Initialiser / DeInitializer

    init(
        router: Router<PostEndpoint, Model> = Router<PostEndpoint, Model>()
       ) {
        self.router = router
    }
}

// MARK: - PostService & PostServiceDelegate

extension PostService {
    func fetchPosts(completion: @escaping PostCompletion) {
        
    }
}
