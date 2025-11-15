//
//  HorizontalSeparatorView.swift
//
//
//  Created by user on 31.05.2024.
//

import UIKit

// MARK: - Refactored BOKHorizontalSeparatorView

public class HorizontalSeparatorView: ConstantColorView {
    
    // MARK: - Properties
    
    static let separatorThickness: CGFloat = 1.0 / UIScreen.main.scale
    
    public override var intrinsicContentSize: CGSize {
        return HorizontalSeparatorView.intrinsicContentSize
    }
    
    // MARK: - Private properties
    
    private static let intrinsicContentSize = CGSize(
        width: UIView.noIntrinsicMetric,
        height: HorizontalSeparatorView.separatorThickness
    )

    // MARK: - Life cycle

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }

    public convenience init() {
        self.init(
            frame: CGRect(
                origin: .zero,
                size: HorizontalSeparatorView.intrinsicContentSize
            )
        )
    }
    
    // MARK: - Private methods

    private func commonInit() {
        // TODO:  В оригинале цвет gray100. Заменить после подтягивания модуля цветов
        constantColor = .gray
    }
}
