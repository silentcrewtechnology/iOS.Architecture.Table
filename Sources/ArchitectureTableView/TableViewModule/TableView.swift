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
        public let separatorInset: UIEdgeInsets
        public let dataSources: UITableViewDataSource
        public let delegate: UITableViewDelegate
        public var didTapGesture: ClosureEmpty = {}

        public init(
            allowsSelection: Bool = true,
            separatorColor: UIColor = .clear,
            backgroundColor: UIColor = .clear,
            rowHeight: CGFloat,
            separatorInset: UIEdgeInsets = .zero,
            dataSources: UITableViewDataSource,
            delegate: UITableViewDelegate,
            didTapGesture: @escaping ClosureEmpty = {}
        ) {
            self.allowsSelection = allowsSelection
            self.separatorInset = separatorInset
            self.separatorColor = separatorColor
            self.backgroundColor = backgroundColor
            self.rowHeight = rowHeight
            self.dataSources = dataSources
            self.delegate = delegate
            self.didTapGesture = didTapGesture
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
        showsVerticalScrollIndicator = false
        cornerRadius(
            radius: 10,
            direction: .allCorners,
            clipsToBounds: true
        )
        
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0
        }
    }
    
    private func addGesture() {
        let hideGuest = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapGesture)
        )
        hideGuest.cancelsTouchesInView = false
        addGestureRecognizer(hideGuest)
    }
    
    @objc
    private func didTapGesture() {
        viewProperties.didTapGesture()
    }
}
