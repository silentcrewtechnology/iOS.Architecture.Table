//
//  TableViewUpdater.swift
//
//
//  Created by user on 31.05.2024.
//

import UIKit
import Architecture

public final class TableViewUpdater: ViewUpdater<TableView> {
    
    // MARK: - Public properties
    
    public struct TableViewModel {
        let rowHeight: CGFloat
        
        public init(rowHeight: CGFloat = 64) {
            self.rowHeight = rowHeight
        }
    }
    
    public enum State {
        case createViewProperties(TableViewModel)
        case reloadData([GenericTableViewSectionModel])
        case updateRow([IndexPath])
        case setSection([GenericTableViewSectionModel])
    }
    
    public var state: State? {
        didSet { stateManager() }
    }
    
    public var viewProperties: TableView.ViewProperties
    
    // MARK: - Private properties
    
    private lazy var dataStorage = GenericTableViewDataStorage.empty
    private lazy var dataSource = dataStorage.tableViewDataSource as? GenericTableViewDataSource
    private lazy var delegate = dataStorage.tableViewDelegate as? GenericTableViewDelegate
    
    // MARK: - Life cycle
    
    override public init(
        viewProperties: TableView.ViewProperties,
        update: @escaping Closure<TableView.ViewProperties>
    ) {
        self.viewProperties = viewProperties
        
        super.init(
            viewProperties: viewProperties,
            update: update
        )
    }
    
    // MARK: - Private methods
    
    private func stateManager() {
        guard let state else { return }
        
        switch state {
        case .createViewProperties(let tableViewModel):
            viewProperties = TableView.ViewProperties(
                dataStorage: dataStorage,
                setupTableView: setupTableView,
                rowHeight: tableViewModel.rowHeight,
                isReload: false
            )
            update(viewProperties)
            setupDataStorage()
        case .reloadData(let sections):
            reloadData(with: sections)
        case .updateRow(let indexPath):
            updateRow(with: indexPath)
        case .setSection(let sections):
            dataStorage.update(with: sections)
        }
    }
    
    private func setupTableView(with tableView: UITableView) {
        dataStorage.registerFor(tableView)
        tableView.reloadData()
    }
    
    private func reloadData(with sections: [GenericTableViewSectionModel]) {
        dataStorage.update(with: sections)
        viewProperties.isReload = true
        update(viewProperties)
        viewProperties.isReload = false
    }
    
    private func updateRow(with indexPath: [IndexPath]) {
        dataSource?.updateRow(with: indexPath)
    }
    
    private func setupDataStorage() {
        dataStorage.defaultSeparatorStyle = .none
    }
}
