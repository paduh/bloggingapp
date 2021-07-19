//
//  Text.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - Text

struct Text: RawRepresentable {
    
    var rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Text {
    static let ok = Text(rawValue: "Ok")
    static let bloggingApp = Text(rawValue: "Blogging App")
    static let cancel = Text(rawValue: "Cancel")
    static let unknownError = Text(rawValue: "Unknown Error")
    static let cannotDequeueheader = Text(rawValue: "Could not dequeue header cell with type")
    static let cannotDequeueCell = Text(rawValue: "Could not dequeue cell with type")
    static let posts = Text(rawValue: "Posts")
}
