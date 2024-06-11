//
//  GenericTableViewDataSource.swift
//
//
//  Created by user on 31.05.2024.
//

import Foundation
import UIKit

public class GenericTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private properties
    
    private weak var dataStorage: GenericTableViewDataStorage?
    private weak var tableView: UITableView?
    
    // MARK: - Life cycle
    
    public init(with dataStorage: GenericTableViewDataStorage) {
        self.dataStorage = dataStorage
    }
    
    // MARK: - Public methods
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        self.tableView = tableView
        if let dataStorage = dataStorage {
            return dataStorage.count
        } else {
            return .zero
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataStorage = dataStorage {
            return dataStorage[section].count
        } else {
            return .zero
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataStorage = dataStorage {
            return dataStorage[indexPath].cellFor(
                tableView,
                at: indexPath,
                defaultSeparator: dataStorage.defaultSeparatorStyle
            )
        } else {
            return UITableViewCell()
        }
    }
    
    public func deleteSections(indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        tableView?.beginUpdates()
        indexPaths.forEach { indexPath in
            dataStorage?.sections[indexPath.section].delete(with: indexPath.row)
            dataStorage?.sections.remove(at: indexPath.section)
        }
        
        let sections = indexPaths.map { $0.section }
        let indexSet = IndexSet(sections)
        tableView?.deleteSections(indexSet, with: animation)
        tableView?.endUpdates()
    }
    
    public func deleteRow(indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        tableView?.beginUpdates()
        indexPaths.forEach { indexPath in
            dataStorage?.sections[indexPath.section].delete(with: indexPath.row)
        }
        
        tableView?.deleteRows(at: indexPaths, with: animation)
        tableView?.endUpdates()
    }
    
    public func insertRow(
        indexPath: IndexPath,
        row tableViewRowModel: TableViewRowModel,
        with animation: UITableView.RowAnimation = .none
    ) {
        tableView?.beginUpdates()
        dataStorage?.sections[indexPath.section].insert(with: indexPath, row: tableViewRowModel)
        tableView?.insertRows(at: [indexPath], with: animation)
        tableView?.endUpdates()
    }
    
    public func updateRow(with indexPaths: [IndexPath], animation: UITableView.RowAnimation = .none) {
        tableView?.reloadRows(at: indexPaths, with: animation)
    }
    
    public func updateLastRow(after indexPath: IndexPath, animation: UITableView.RowAnimation = .none) {
        guard let countRow = tableView?.numberOfRows(inSection: indexPath.section) else { return }
        
        for index in indexPath.row..<countRow {
            let reloadIndexPath = IndexPath(row: index, section: indexPath.section)
            tableView?.reloadRows(at: [reloadIndexPath], with: animation)
        }
    }
}
