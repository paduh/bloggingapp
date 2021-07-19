//
//  Assembly.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import UIKit

enum Assembly {
    
    static var postDetailsController: PostDetailsController {
        let postService: PostServiceDelegate = PostService<[Post]>()
        let presenter = PostPresenter(postService: postService)
        let controller = PostDetailsController(presenter: presenter)
        return controller
    }
}
