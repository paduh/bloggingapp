//
//  PostPresenter.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - PostPresenter

class PostPresenter: PostPresenterPresentable {

    // MARK: Properties
    
    var postService: PostServiceDelegate
    var postView: PostView?
    
    // MARK: Initialiser
    
    init(postService: PostServiceDelegate = PostService()) {
        self.postService = postService
    }
    
    func viewDidLoad() {
        fetchPosts()
    }
    
    func detachView() {
        postView = nil
    }
    
    func attacheView(_ view: PostView) {
        postView = view
    }
}

// MARK: - API

extension PostPresenter {
    func fetchPosts() {
        postService.fetchPosts { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case.failure(let error):
                self.postView?.showErrorMsg(msg: error.title)
            case.success(let data):
                guard let posts = data else {
                    self.postView?.setEmptyState()
                    return
                }
                self.postView?.loadPosts(posts: posts)
            }
        }
    }
}
