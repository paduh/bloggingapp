//
//  PostNavigator.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import UIKit

// MARK: - PostNavigator

final class PostNavigator: Navigator {
    
    // MARK: Properties

    private var navigationController: UINavigationController!
    typealias Object = Post
    
    // MARK: Initialiser

     init(navigationController: UINavigationController
     ) {
            self.navigationController = navigationController
     }
    
    // MARK: Destination
    
    enum Destination {
        case postDetails

    }
    
    func navigate(to destination: Destination, object: Object?) {
        let vc = makeViewController(for: destination)
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: Helpers

private extension PostNavigator {
    func makeViewController(for destination: Destination) -> UIViewController {
       switch destination{
       case .postDetails:
           return UIViewController()
       }
    }
}
