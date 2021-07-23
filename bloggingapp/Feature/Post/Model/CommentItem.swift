//
//  CommentItem.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - CommentItem

final class CommentItem {

    // MARK: Properties

    let email: String
    let title: String
    let body: String
    let model: Comment

    // MARK: Initialiser

    init(_ model: Comment) {
        self.model = model
        email = model.email
        title = model.name
        body = model.body
    }
}
