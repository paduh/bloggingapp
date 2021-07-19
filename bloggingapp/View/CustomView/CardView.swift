//
//  CardView.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation
import UIKit

// MARK: - CardView

@IBDesignable
final class CardView: UIView {
    
    // MARK: - IBInspectable Properties
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.gray
    @IBInspectable var shadowOpacity: Float = 0.2
    @IBInspectable var cardRadius: CGFloat = 10
    @IBInspectable var cornerRadius: CGFloat = 0
    
    public override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}

