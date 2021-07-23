//
//  CommentCell.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import UIKit

// MARK: - CommentCell

final class CommentCell: UITableViewCell {

    // MARK: IBOutlets

    @IBOutlet weak private var emailLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!

    // MARK: Life cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = .none
        bodyLabel.text = .none
    }
}

// MARK: CommentCell & CellPresentable

extension CommentCell: CellPresentable {
    typealias Item = CommentItem

    func configureCell(item: CommentItem) {
        emailLabel.text = item.email
        titleLabel.text = item.title
        bodyLabel.text = item.body
    }
}
