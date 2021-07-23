//
//  UIViewController+Extension.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021
//

import UIKit

// MARK: - UIViewController Extension

extension UIViewController {

    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }

    func showAlert(msg: String, twoActions: Bool = false, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: Text.bloggingApp.rawValue, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Text.okay.rawValue, style: .default, handler: handler)
        let cancelAction = UIAlertAction(title: Text.cancel.rawValue, style: .default, handler: nil)
        if twoActions {
            alert.addAction(cancelAction)
            alert.addAction(okAction)
        } else {
            alert.addAction(okAction)
        }

        present(alert, animated: true, completion: nil)
    }
}
