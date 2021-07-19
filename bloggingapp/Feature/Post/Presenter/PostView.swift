//
//  PostView.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

protocol PostView {
    var pageTitle: String { get }
    
    func showLoading()
    func hideLoading()
    func showErrorMsg(msg: String)
    func setEmptyState()
    func loadPosts(posts: [Post])
}
