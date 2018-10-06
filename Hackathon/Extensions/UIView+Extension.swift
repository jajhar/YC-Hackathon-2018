//
//  UIView+Extension.swift
//  Hackathon
//
//  Created by James on 4/26/18.
//  Copyright © 2018 James. All rights reserved.
//

import UIKit

public enum AutoLayoutEdge {
    case top
    case bottom
    case left
    case right
}

public extension UIView {
    
    func constrainTo(edges: AutoLayoutEdge...) {
        for edge in edges {
            _ = constrainTo(edge: edge)
        }
    }
    
    @discardableResult
    func constrainTo(edge: AutoLayoutEdge) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        
        var constraint: NSLayoutConstraint?
        
        switch edge {
        case .top:
            constraint = topAnchor.constraint(equalTo: superview.topAnchor)
        case .bottom:
            constraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        case .left:
            constraint = leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        case .right:
            constraint = trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        }
        
        constraint?.isActive = true
        return constraint
    }
    
    func constrainToSuperview() {
        constrainTo(edges: .top, .bottom, .left, .right)
    }
    
    @discardableResult
    func constrainWidth(_ width: CGFloat) -> NSLayoutConstraint? {
        let widthConstraint = NSLayoutConstraint(item: self,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: width)
        addConstraint(widthConstraint)
        widthConstraint.isActive = true
        return widthConstraint
    }
    
    @discardableResult
    func constrainHeight(_ height: CGFloat) -> NSLayoutConstraint? {
        let heightConstraint = NSLayoutConstraint(item: self,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: height)
        addConstraint(heightConstraint)
        heightConstraint.isActive = true
        return heightConstraint
    }
    
    func constrainToCenter() {
        guard let superview = superview else { return }
        
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func constrainToCenterHorizontal() {
        guard let superview = superview else { return }
        
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    func constrainToCenterVertical() {
        guard let superview = superview else { return }
        
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }

    class func instanceFromNib() -> UIView? {
        return UINib(nibName: "\(self)", bundle: Bundle(for: self)).instantiate(withOwner: nil, options: nil).first as? UIView
    }
}

extension UIView {
    
    func addDropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addDropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize = .zero, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
}
