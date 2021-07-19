//
//  PostPresenterPresentable.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

protocol PostPresenterPresentable {
    var postService: PostServiceDelegate { get set }
    var postView: PostView? { get set }
    var navigator: PostNavigator { get set }
    
    func viewDidLoad()
    func detachView()
    func attacheView(_ view: PostView)
    func fetchPosts()
}
