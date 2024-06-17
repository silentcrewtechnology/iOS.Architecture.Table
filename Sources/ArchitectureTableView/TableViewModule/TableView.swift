//
//  TableView.swift
//
//
//  Created by user on 31.05.2024.
//

import Architecture
import UIKit
import Components

public final class TableView: UITableView, ViewProtocol {
    
    // MARK: - Public properties
    
    public struct ViewProperties {
        public let allowsSelection: Bool
        public let separatorColor: UIColor
        public let backgroundColor: UIColor
        public let rowHeight: CGFloat
        public let radius: CGFloat
        public let separatorInset: UIEdgeInsets
        public let dataSources: UITableViewDataSource
        public let delegate: UITableViewDelegate
        public var didTapGesture: ClosureEmpty?
        public let isScrollEnabled: Bool
        public let accessibilityId: String?

        public init(
            allowsSelection: Bool = true,
            separatorColor: UIColor = .clear,
            backgroundColor: UIColor = .clear,
            rowHeight: CGFloat = 72,
            radius: CGFloat = 0,
            separatorInset: UIEdgeInsets = .zero,
            dataSources: UITableViewDataSource,
            delegate: UITableViewDelegate,
            didTapGesture: ClosureEmpty? = nil,
            isScrollEnabled: Bool = true,
            accessibilityId: String? = nil
        ) {
            self.allowsSelection = allowsSelection
            self.separatorInset = separatorInset
            self.separatorColor = separatorColor
            self.backgroundColor = backgroundColor
            self.rowHeight = rowHeight
            self.radius = radius
            self.dataSources = dataSources
            self.delegate = delegate
            self.didTapGesture = didTapGesture
            self.isScrollEnabled = isScrollEnabled
            self.accessibilityId = accessibilityId
        }
    }
    
    public var viewProperties: ViewProperties
    
    // MARK: - Life cycle
    
    public init(
        viewProperties: ViewProperties,
        style: UITableView.Style
    ) {
        self.viewProperties = viewProperties
        
        super.init(frame: .zero, style: style)
        
        setupTableView()
        addGesture()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func update(with viewProperties: ViewProperties) {
        self.viewProperties = viewProperties
        accessibilityIdentifier = viewProperties.accessibilityId
        setupTableView()
        reloadData()
    }
    
    // MARK: - Private methods
    
    private func setupTableView() {
        delegate = viewProperties.delegate
        dataSource = viewProperties.dataSources
        reloadData()
        backgroundColor = viewProperties.backgroundColor
        estimatedRowHeight = viewProperties.rowHeight
        separatorColor = viewProperties.separatorColor
        separatorInset = viewProperties.separatorInset
        allowsSelection = viewProperties.allowsSelection
        isScrollEnabled = viewProperties.isScrollEnabled
        showsVerticalScrollIndicator = false
        cornerRadius(
            radius: viewProperties.radius,
            direction: .allCorners,
            clipsToBounds: true
        )
        
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0
        }
    }
    
    private func addGesture() {
        guard viewProperties.didTapGesture != nil else { return }
        
        let hideGuest = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapGesture)
        )
        hideGuest.cancelsTouchesInView = false
        addGestureRecognizer(hideGuest)
    }
    
    @objc
    private func didTapGesture() {
        viewProperties.didTapGesture?()
    }
}
