//
//  PostCell.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import UIKit

// MARK: - PostCell

final class PostCell: UITableViewCell {

    // MARK: IBOutlets

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    
    // MARK: Life cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = .none
        bodyLabel.text = .none
    }
}

// MARK: - PostCell & CellPresentable

extension PostCell: CellPresentable {
    typealias Item = PostItem

    func configureCell(item: PostItem) {
        titleLabel.text = item.title
        bodyLabel.text = item.body
    }
}
