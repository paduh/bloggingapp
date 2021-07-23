//
//  GenericTableViewDelegate.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import UIKit

// MARK: - UITableViewDelegateDataSource

typealias UITableViewDelegateDataSource = UITableViewDelegate & UITableViewDataSource

// MARK: - GenericCollectionViewDataSourceDelegate

final class GenericTableViewDelegate<Model, Cell: UITableViewCell>: NSObject, UITableViewDelegateDataSource {

    // MARK: Properties

    public typealias CellConfigurator = ((Model, Cell) -> Void)
    public typealias DidSelectItem = ((Int) -> Void)
    public typealias LoadMore = ((Bool) -> Void)

    var models: [Model]
    private let cellConfigurator: CellConfigurator
    public var didSelectItemAt: DidSelectItem?
    public var loadMore: LoadMore?

    // MARK: Initializer

    public init(models: [Model], cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.cellConfigurator = cellConfigurator
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  models.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeue(Cell.self, for: indexPath)
        cellConfigurator(model, cell)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItemAt?(indexPath.item)
    }
}
