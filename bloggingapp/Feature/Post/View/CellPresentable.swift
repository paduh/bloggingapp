//
//  CellPresentable.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation

// MARK: - CellPresentable

protocol CellPresentable {
    associatedtype Item
    
    func configureCell(item: Item)
}
