//
//  GenericTableViewDelegate.swift
//
//
//  Created by user on 31.05.2024.
//

import UIKit

public class GenericTableViewDelegate: NSObject, UITableViewDelegate {
    
    // MARK: - Private properties
    
    private weak var dataStorage: GenericTableViewDataStorage?
    
    // MARK: - Life cycle
    
    public init(with dataStorage: GenericTableViewDataStorage) {
        self.dataStorage = dataStorage
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataStorage = dataStorage {
            dataStorage[indexPath].didSelectFor(tableView: tableView, at: indexPath)
        }
    }
    
    // MARK: - Public methods
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let rowModel = dataStorage?[indexPath] else {
            return tableView.rowHeight
        }
        
        if rowModel.hidden {
            // beginUpdate с ios 15 обрабатывает только те ячейки, которые имеют значение больше 0.
            // Поэтому если высота равна 0.0, то больше не настраивает их.
            return 0.01
        } else if let height = rowModel.rowHeight {
            return height
        } else {
            return tableView.rowHeight
        }
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if dataStorage?[section].footerProvider == nil {
            return .zero
        } else {
            return tableView.sectionFooterHeight
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let provider = dataStorage?[section].footerProvider else { return UIView() }
        
        return provider(tableView, section)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if dataStorage?[section].headerProvider == nil {
            return .zero
        } else {
            return tableView.sectionHeaderHeight
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let provider = self.dataStorage?[section].headerProvider else {
            return nil
        }
        return provider(tableView, section)
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let provider = dataStorage?.paginationProvider,
              let dataStorage = dataStorage
        else { return }

        let isLastSection = indexPath.section == dataStorage.count - 1
        let isLastCellInSection = indexPath.row == dataStorage[indexPath.section].count - 1

        if isLastSection, isLastCellInSection {
            provider()
        }
    }
}
