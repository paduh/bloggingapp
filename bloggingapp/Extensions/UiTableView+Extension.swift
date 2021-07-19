//
//  UiTableView+Extension.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import UIKit

extension UITableView {
    func registerHeader<T: UITableViewHeaderFooterView>(_: T.Type, reuseIdentifier: String? = nil) {
        let reuseId = reuseIdentifier ?? "\(T.self)"
        self.register(UINib(nibName: reuseId, bundle: Bundle(for: T.self)), forHeaderFooterViewReuseIdentifier: reuseId)
    }
    
    func dequeueHeader<T: UITableViewHeaderFooterView>(_: T.Type, for Section: Int) -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T
        else { fatalError("\(Text.cannotDequeueheader.rawValue) \(T.self)") }
        return cell
    }
    
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        let reuseId = reuseIdentifier ?? "\(T.self)"
        self.register(UINib(nibName: reuseId, bundle: Bundle(for: T.self)), forCellReuseIdentifier: reuseId)
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath? = nil) -> T {
        if let indexPath = indexPath {
            guard
                let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                               for: indexPath) as? T
                else { fatalError("\(Text.cannotDequeueCell.rawValue) \(T.self)") }
            return cell
            
        }
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T
            else { fatalError("\(Text.cannotDequeueCell.rawValue) \(T.self)") }
        return cell
    }
}

