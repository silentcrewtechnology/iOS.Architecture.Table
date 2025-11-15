//
//  GenericTableViewSectionModel.swift
//
//
//  Created by user on 31.05.2024.
//

import UIKit

public final class GenericTableViewSectionModel {
    
    public typealias RowsCollection = [TableViewRowModel]
    
    // MARK: - Public properties
    
    public static let empty = GenericTableViewSectionModel(with: [])
    public var headerProvider: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    public var footerProvider: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    
    public var count: Int {
        return rows.count
    }

    public var isEmpty: Bool {
        return rows.isEmpty
    }
    
    // MARK: - Private properties
    
    private var rows: RowsCollection
    
    // MARK: - Life cycle
    
    public init(with rows: RowsCollection) {
        self.rows = rows
    }
    
    // MARK: - Public methods
    
    public func registerFor(_ tableView: UITableView) {
        for row in rows {
            row.registerFor(tableView)
        }
    }

    public func updateCells() {
        rows.forEach { $0.updateCell() }
    }

    public func updateRow(row: Int, rowModel: TableViewRowModel) {
        rows[row] = rowModel
    }

    public func hiddenToggleRows() {
        rows.forEach { $0.hidden.toggle() }
    }
    
    public func delete(with row: Int) {
        rows.remove(at: row)
    }
    
    public func insert(with indexPath: IndexPath, row tableViewRowModel: TableViewRowModel) {
        rows.insert(tableViewRowModel, at: indexPath.row)
    }
    
    public subscript(row: IndexPath.Element) -> RowsCollection.Element {
        return rows[row]
    }
}
