//
//  Navigator.swift
//  Infinum TV Shows
//
//  Created by Aduh Perfect on 13/06/2021.
//

import Foundation

// MARK: - Navigator

protocol Navigator {
    associatedtype Destination
    associatedtype Object

    func navigate(to destination: Destination, object: Object?)
}
