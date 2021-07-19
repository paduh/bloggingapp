//
//  PostDetailsController.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import UIKit

// MARK: PostDetailsController

final class PostDetailsController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var activityView: UIActivityIndicatorView!
    @IBOutlet weak private var tableView: UITableView!{
        didSet {
            tableView.register(PostCell.self)
        }
    }
    
    // MARK:  Properties
    
    private var post: Post?
    private var presenter: PostPresenterPresentable!
    private var dataSource: GenericTableViewDelegate<Comment, CommentCell>!

    
    // MARK: Life cycle methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setupDataSource() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.isHidden = true
    }
    
    private func handlePresenter() {
        presenter = PostPresenter(navigator: PostNavigator(navigationController: navigationController))
        presenter.viewDidLoad()
        presenter.attacheView(self)
    }
}

// MARK: - Helpers

private extension PostDetailsController {
    func handleDataSource(comments: [Comment]) -> GenericTableViewDelegate<Comment, CommentCell> {
        return GenericTableViewDelegate<Comment, CommentCell>(models: comments, cellConfigurator: { (comment, cell) in
            let item = CommentItem(comment)
            cell.configureCell(item: item)
        })
    }
    
    func showLoader() {
        activityView.isHidden = false
        activityView.startAnimating()
    }
    
    func hideLoader() {
        activityView.isHidden = true
        activityView.stopAnimating()
    }
}

// MARK: -  PostController & PostView

extension PostDetailsController: PostView {
    var pageTitle: String {
        Text.posts.rawValue
    }
    
    func showLoading() {
        showLoader()
    }
    
    func hideLoading() {
        hideLoader()
    }
    
    func showErrorMsg(msg: String) {
        showAlert(msg: msg)
    }
    
    func setEmptyState() {
        
    }
    
    func loadPostComments(comments: [Comment]) {
        
    }
}
