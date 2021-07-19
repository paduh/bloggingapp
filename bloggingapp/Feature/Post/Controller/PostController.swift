//
//  PostController.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import UIKit

// MARK: -  PostController

final class PostController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var activityView: UIActivityIndicatorView!
    @IBOutlet weak private var tableView: UITableView!{
        didSet {
            tableView.register(PostCell.self)
        }
    }
    
    // MARK:  Properties
    
    private var presenter: PostPresenterPresentable!
    private var dataSource: GenericTableViewDelegate<Post, PostCell>!
    
    // MARK: Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.topViewController?.title = pageTitle
        handlePresenter()
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

private extension PostController {
    func handleDataSource(posts: [Post]) -> GenericTableViewDelegate<Post, PostCell> {
        return GenericTableViewDelegate<Post, PostCell>(models: posts, cellConfigurator: { (post, cell) in
            let item = PostItem(post)
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

extension PostController: PostView {
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
    
    func loadPosts(posts: [Post]) {
        dataSource = handleDataSource(posts: posts)
        setupDataSource()
        tableView.isHidden = posts.isEmpty
        tableView.reloadData()
    }
}
