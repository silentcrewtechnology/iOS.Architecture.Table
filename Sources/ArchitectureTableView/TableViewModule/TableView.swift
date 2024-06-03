//
//  TableView.swift
//
//
//  Created by user on 31.05.2024.
//

import Architecture
import UIKit

public final class TableView: UITableView, ViewProtocol {
    
    // MARK: - Properties

    public struct ViewProperties {
        let dataStorage: GenericTableViewDataStorage
        let setupTableView: Closure<UITableView>
        let rowHeight: CGFloat
        var isReload: Bool
        
        public init(
            dataStorage: GenericTableViewDataStorage = .empty,
            setupTableView: @escaping Closure<UITableView> = { _ in },
            rowHeight: CGFloat = 72,
            isReload: Bool = false
        ) {
            self.dataStorage = dataStorage
            self.setupTableView = setupTableView
            self.rowHeight = rowHeight
            self.isReload = isReload
        }
    }
    
    public var viewProperties: ViewProperties
    
    // MARK: - Life cycle
    
    public init(
        style: UITableView.Style = .plain,
        viewProperties: ViewProperties
    ) {
        self.viewProperties = viewProperties
        
        super.init(frame: .zero, style: style)
    
        self.viewProperties.setupTableView(self)
        tableFooterView = UIView()
        keyboardDismissMode = .onDrag
        separatorStyle = .none
        
        setup(with: viewProperties)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func update(with viewProperties: ViewProperties) {
        self.viewProperties = viewProperties
        
        reload(with: viewProperties)
    }
    
    // MARK: - Private properties
    
    private func setup(with viewProperties: ViewProperties) {
        delegate = viewProperties.dataStorage.tableViewDelegate
        dataSource = viewProperties.dataStorage.tableViewDataSource
        estimatedRowHeight = viewProperties.rowHeight
        rowHeight = UITableView.automaticDimension
    }
    
    private func reload(with viewProperties: ViewProperties) {
        guard viewProperties.isReload == true else { return }
        self.viewProperties.dataStorage.registerFor(self)
        self.reloadData()
    }
}
