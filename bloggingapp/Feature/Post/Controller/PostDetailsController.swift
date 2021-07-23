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

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    @IBOutlet weak private var activityView: UIActivityIndicatorView!
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.register(CommentCell.self)
        }
    }

    // MARK: Properties

    var post: Post?
    private var presenter: PostPresenterPresentable!
    private var dataSource: GenericTableViewDelegate<Comment, CommentCell>!

    // MARK: Initialiser

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(presenter: PostPresenterPresentable) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    // MARK: Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handlePresenter()
        guard let post = post else { return }
        presenter.fetchPostComment(postId: post.id)
        navigationController?.topViewController?.title = pageTitle
    }

    private func setupDataSource() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.isHidden = true
    }

    private func handlePresenter() {
        presenter = PostPresenter()
        presenter.viewDidLoad()
        presenter.attacheView(self)
    }

    private func setupView() {
        guard let post = post else { return }
        titleLabel.text = post.title
        bodyLabel.text = post.body
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

// MARK: - PostController & PostView

extension PostDetailsController: PostView {
    var pageTitle: String {
        Text.comments.rawValue
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

    func setEmptyState() {}

    func loadPostComments(comments: [Comment]) {
        dataSource = handleDataSource(comments: comments)
        setupDataSource()
        tableView.isHidden = comments.isEmpty
        tableView.reloadData()
    }
}
