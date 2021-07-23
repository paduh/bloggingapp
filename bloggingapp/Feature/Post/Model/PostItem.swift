//
//  PostItem.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - PostItem

final class PostItem {

    // MARK: Properties

    let title: String
    let body: String
    let model: Post

    // MARK: Initialiser

    init(_ model: Post) {
        self.model = model
        self.title = model.title
        self.body = model.body
    }
}
