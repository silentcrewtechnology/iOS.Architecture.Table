//
//  GenericTableViewCellWrapper.swift
//
//
//  Created by user on 03.06.2024.
//

import UIKit
import SnapKit

public class GenericTableViewCellWrapper<ContentType: UIView & Reusable>: UITableViewCell {
    
    // MARK: - Public properties
    
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            if oldValue != contentInset {
                containedView.snp.remakeConstraints {
                    $0.edges.equalToSuperview().inset(contentInset)
                }
            }
        }
    }
    
    public lazy var containedView: ContentType = {
        if let path = Bundle.main.path(forResource: String(describing: ContentType.self), ofType: "nib"),
           let firstObject = Bundle.main.loadNibNamed(
            String(describing: ContentType.self),
            owner: nil,
            options: nil)?.first as? ContentType
        {
            return firstObject
        } else {
            return ContentType(frame: bounds)
        }
    }()
    
    // MARK: - Life cycle
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        
        containedView.prepareForReuse()
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        contentView.addSubview(containedView)
        containedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
