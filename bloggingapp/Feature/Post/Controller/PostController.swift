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
    
    private var posts = [Post]() {
        didSet {
            tableView.isHidden = posts.isEmpty
            tableView.reloadData()
        }
    }
    private var presenter: PostPresenterPresentable!
    private var dataSource: GenericTableViewDelegate<Post, PostCell>!
    private var navigator: PostNavigator!
    
    // MARK:  Initialiser
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.topViewController?.title = pageTitle
        handlePresenter()
        handleNavigator()
    }
    
    private func setupDataSource() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.isHidden = true
    }
    
    private func handleNavigator() {
        navigator = PostNavigator(navigationController: navigationController)
    }
    
    private func handlePresenter() {
        presenter = PostPresenter()
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
    
    func handleDidSelect() -> ((Int) -> Void) {
        return { [weak self] index in
            guard let self = self else { return }
            let post = self.posts[index]
            self.navigator.navigate(to: .postDetails, object: post)
        }
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
        self.posts = posts
        dataSource = handleDataSource(posts: posts)
        setupDataSource()
        tableView.isHidden = posts.isEmpty
        tableView.reloadData()
        dataSource.didSelectItemAt = handleDidSelect()
    }
}
