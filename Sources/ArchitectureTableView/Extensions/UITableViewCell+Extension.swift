//
//  UITableViewCell+Extension.swift
//
//
//  Created by user on 31.05.2024.
//

import Foundation
import UIKit

public extension UITableViewCell {
    
    // MARK: - Refactored bok_shouldAddSeparatorForRow
    
    func shouldAddSeparator(forRow row: Int, with totalRows: Int) -> Bool {
        return row + 1 < totalRows
    }
    
    // MARK: - Refactored bok_applyBottomSeparatorWithDefaultMarginForRow
    
    func applyBottomSeparatorWithDefaultMargin(forRow row: Int, with totalRows: Int) {
        if shouldAddSeparator(forRow: row, with: totalRows) {
            applyBottomSeparatorWithDefaultMargin()
        } else {
            removeBottomSeparator()
        }
    }
    
    // MARK: - Refactored bok_applyBottomSeparatorWithLeftMargin
    
    func applyBottomSeparator(with leftMargin: CGFloat, forRow row: Int, with totalRows: Int) {
        if shouldAddSeparator(forRow: row, with: totalRows) {
            applyBottomSeparator(with: leftMargin)
        } else {
            removeBottomSeparator()
        }
    }
     
    // MARK: - Refactored bok_applyBottomSeparatorWithDefaultMargin
    
    func applyBottomSeparatorWithDefaultMargin() {
        applyBottomSeparator(with: separatorInset.left)
    }
    
    // MARK: - Refactored bok_applyTopSeparatorWithDefaultMargin
    
    func applyTopSeparatorWithDefaultMargin() {
        applyTopSeparator(with: separatorInset.left)
    }
}

public extension UITableViewCell {
    static var identifier: String { .init(describing: self) }
}
