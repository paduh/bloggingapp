//
//  Comment.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK:-  Comment

struct Comment: Codable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
    
    init(
        id: Int,
        postId: Int,
        name: String,
        email: String,
        body: String
    ) {
        self.id = id
        self.postId = postId
        self.name = name
        self.email = email
        self.body = body
    }
}
