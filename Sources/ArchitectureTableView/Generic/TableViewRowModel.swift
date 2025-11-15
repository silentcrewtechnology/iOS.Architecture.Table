//
//  TableViewRowModel.swift
//
//
//  Created by user on 31.05.2024.
//

import UIKit
import AccessibilityIds

public class TableViewRowModel {
    
    public typealias ConfigurationBlock = ((UITableViewCell, IndexPath) -> Void)
    public typealias ActionBlock = ((UITableView, IndexPath) -> Void)
    
    // MARK: - Properties
    
    public enum SeparatorInsetSettings {
        case defaultInset
        case cellConfigured
        case custom(inset: CGFloat)
    }
    
    public enum SeparatorStyle {
        case undefined
        case none
        case always(settings: SeparatorInsetSettings)
        case exceptLast(settings: SeparatorInsetSettings)
    }
    
    public var rowHeight: CGFloat?
    public var hidden: Bool = false
    public var separatorStyle: SeparatorStyle = .undefined
    
    // MARK: - Private properties
    
    private var configurationBlock: ConfigurationBlock?
    private var actionBlock: ActionBlock?
    private var cellType: UITableViewCell.Type
    private var initializesFromNib: Bool
    
    private(set) weak var cell: UITableViewCell?
    private(set) var indexPath: IndexPath?
    
    // MARK: - Life cycle
    
    public init(){
        cellType = UITableViewCell.self
        configurationBlock = nil
        actionBlock = nil
        initializesFromNib = false
    }
    
    public init(
        with cellType: UITableViewCell.Type,
        configuration configurationBlock: ConfigurationBlock?,
        andAction actionBlock: ActionBlock?,
        initializesFromNib: Bool
    ) {
        self.cellType = cellType
        self.configurationBlock = configurationBlock
        self.actionBlock = actionBlock
        self.initializesFromNib = initializesFromNib
    }
    
    // MARK: - Private methods
    
    private func insetForSeparatorSettings(
        _ settings: SeparatorInsetSettings,
        for cell: UITableViewCell
    ) -> CGFloat {
        switch settings {
        case .defaultInset:
            return 72.0
        case .cellConfigured:
            return cell.separatorInset.left
        case .custom(let inset):
            return inset
        }
    }
    
    private func configureSeparatorFor(
        _ cell: UITableViewCell,
        at indexPath: IndexPath,
        in tableView: UITableView,
        defaultStyle: SeparatorStyle
    ) {
        let style: SeparatorStyle
        
        switch separatorStyle {
        case .undefined:
            style = defaultStyle
        default:
            style = separatorStyle
        }
        
        switch style {
        case .undefined:
            break
        case .none:
            cell.removeBottomSeparator()
        case .always(let settings):
            cell.applyBottomSeparator(with: insetForSeparatorSettings(settings, for: cell))
        case .exceptLast(let settings):
            cell.applyBottomSeparator(
                with: insetForSeparatorSettings(settings, for: cell),
                forRow: indexPath.row,
                with: tableView.numberOfRows(inSection: indexPath.section)
            )
        }
    }
    
    // MARK: - Public Methods
    
    public func registerFor(_ tableView: UITableView) {
        if initializesFromNib {
            tableView.register(
                UINib(nibName: cellType.identifier, bundle: nil),
                forCellReuseIdentifier: cellType.identifier
            )
        } else {
            tableView.register(cellType.self, forCellReuseIdentifier: cellType.identifier)
        }
    }
    
    public func cellFor(
        _ tableView: UITableView,
        at indexPath: IndexPath,
        defaultSeparator: SeparatorStyle
    ) -> UITableViewCell {
        let cell = provideCellFor(tableView, at: indexPath)
        cell.accessibilityIdentifier = TableArchAccessibilityIDs.TableViewRowModel.cell + "\(indexPath.section)_\(indexPath.row)"
        configureSeparatorFor(cell, at: indexPath, in: tableView, defaultStyle: defaultSeparator)
        
        if let configurationBlock = configurationBlock {
            configurationBlock(cell, indexPath)
        }
        
        if hidden {
            cell.clipsToBounds = true
        }
        
        self.cell = cell
        self.indexPath = indexPath
        
        return cell
    }
    
    public func didSelectFor(tableView: UITableView, at indexPath: IndexPath) {
        if let actionBlock = actionBlock {
            actionBlock(tableView, indexPath)
        }
    }
    
    public func provideCellFor(
        _ tableView: UITableView,
        at indexPath: IndexPath
    ) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
    }
    
    public func updateCell() {
        guard let cell = cell,
              let indexPath = indexPath
        else { return }
        
        configurationBlock?(cell, indexPath)
    }
}
