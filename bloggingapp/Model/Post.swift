//
//  Post.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - Post

struct Post: Codable {

    let userId: Int
    let id: Int
    let title: String
    let body: String

    init(
        userId: Int,
        id: Int,
        title: String,
        body: String
    ) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
