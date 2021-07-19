//
//  PostView.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

protocol PostView {
    func showLoading()
    func hideLoading()
    func showErrorMsg(msg: String)
    func setEmptyState()
    func loadPosts(posts: [Post])
    func setTitle(title: String)
}
