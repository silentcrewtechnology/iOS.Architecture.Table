//
//  ConstantColorView.swift
//
//
//  Created by user on 31.05.2024.
//

import UIKit

// MARK: - Refactored BOKConstantColorView

public class ConstantColorView: UIView {
    
    // MARK: - Properties
    
    public var constantColor: UIColor?
    
    // MARK: - Methods
    
    public func setConstantColor(constantColor: UIColor) {
        self.constantColor = constantColor
    }
    
    public func setBackgroundColor(backgroundColor: UIColor) {
        // Do nothing
    }
}
