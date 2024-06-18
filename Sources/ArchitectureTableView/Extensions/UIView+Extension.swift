//
//  UIView+Extension.swift
//
//
//  Created by user on 05.04.2024.
//

import Foundation
import UIKit

public extension UIView {
    
    // MARK: - Properties
    
    var bottomSeparator: ConstantColorView? {
        get {
            return objc_getAssociatedObject(self, Constants.kCellBottomSeparator) as? ConstantColorView
        }
        set {
            objc_setAssociatedObject(self, Constants.kCellBottomSeparator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var topSeparator: ConstantColorView? {
        get {
            return objc_getAssociatedObject(self, Constants.kCellTopSeparator) as? ConstantColorView
        }
        set {
            objc_setAssociatedObject(self, Constants.kCellTopSeparator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Refactored bok_applyBottomSeparator
    
    func applyBottomSeparator() {
        applyBottomSeparator(with: .zero)
    }
    
    // MARK: - Refactored bok_applyBottomSeparatorWithLeftMargin
    
    func applyBottomSeparator(with leftMargin: CGFloat) {
        if bottomSeparator == nil {
            let separator = HorizontalSeparatorView(
                frame: CGRectMake(
                    .zero,
                    bounds.size.height - HorizontalSeparatorView.separatorThickness,
                    bounds.size.width,
                    HorizontalSeparatorView.separatorThickness
                )
            )
            separator.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
            
            addSubview(separator)
            bottomSeparator = separator
        }
        
        guard let separator = bottomSeparator else { return }
        
        separator.frame = CGRectMake(
            leftMargin,
            bounds.size.height - HorizontalSeparatorView.separatorThickness,
            bounds.size.width - leftMargin,
            HorizontalSeparatorView.separatorThickness
        )
        separator.superview?.bringSubviewToFront(separator)
    }
    
    // MARK: - Refactored bok_removeBottomSeparator
    
    func removeBottomSeparator() {
        if bottomSeparator != nil {
            bottomSeparator?.removeFromSuperview()
            bottomSeparator = nil
        }
    }
    
    // MARK: - Refactored bok_applyTopSeparator
    
    func applyTopSeparator() {
        applyTopSeparator(with: .zero)
    }
    
    // MARK: - Refactored bok_applyTopSeparatorWithLeftMargin
    
    func applyTopSeparator(with leftMargin: CGFloat) {
        if topSeparator == nil {
            let separator = HorizontalSeparatorView(
                frame: CGRectMake(
                    .zero,
                    HorizontalSeparatorView.separatorThickness,
                    bounds.size.width,
                    HorizontalSeparatorView.separatorThickness
                )
            )
            separator.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            
            addSubview(separator)
            topSeparator = separator
        }
        
        guard let separator = topSeparator else { return }
        
        separator.frame = CGRectMake(
            leftMargin,
            HorizontalSeparatorView.separatorThickness,
            bounds.size.width - leftMargin,
            HorizontalSeparatorView.separatorThickness
        )
        separator.superview?.bringSubviewToFront(separator)
    }
    
    // MARK: - Refactored bok_removeTopSeparator
    
    func removeTopSeparator() {
        if topSeparator != nil {
            topSeparator?.removeFromSuperview()
            topSeparator = nil
        }
    }
    
}

// MARK: - Constants

private enum Constants {
    static let kCellBottomSeparator = "kCellBottomSeparator"
    static let kCellTopSeparator = "kCellTopSeparator"
}

public protocol Reusable {
    func prepareForReuse()
}

extension UILabel: Reusable {
    
    public func prepareForReuse() {
        text = nil
    }
}

extension UIImageView: Reusable {
    public func prepareForReuse() {
        image = nil
    }
}
