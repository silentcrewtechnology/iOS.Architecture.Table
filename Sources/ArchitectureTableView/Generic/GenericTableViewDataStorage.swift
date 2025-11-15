//
//  GenericTableViewDataStorage.swift
//
//
//  Created by user on 31.05.2024.
//

import UIKit

public class GenericTableViewDataStorage {
    
    public typealias SectionCollection = [GenericTableViewSectionModel]
    
    // MARK: - Public properties
    
    public var sections: SectionCollection
    public var defaultSeparatorStyle: TableViewRowModel.SeparatorStyle = .undefined

    public var paginationProvider: (() -> Void)?
    
    public static var empty: GenericTableViewDataStorage {
        return GenericTableViewDataStorage(with: [])
    }

    // swiftlint:disable:next weak_delegate
    public lazy var tableViewDelegate: UITableViewDelegate = {
        return customTableViewDelegate.self ?? GenericTableViewDelegate(with: self)
    }()
    
    public lazy var tableViewDataSource: UITableViewDataSource = {
        return customTableViewDataSource.self ?? GenericTableViewDataSource(with: self)
    }()
    
    public var count: Int {
        return sections.count
    }
    
    // MARK: - Private properties
    
    private weak var customTableViewDelegate: UITableViewDelegate?
    private weak var customTableViewDataSource: UITableViewDataSource?
    
    // MARK: - Life cycle

    public required init(with sections: SectionCollection) {
        self.sections = sections
    }

    public convenience init(withSectionArray sections: [[TableViewRowModel]]) {
        self.init(with: sections.map { GenericTableViewSectionModel(with: $0) })
    }

    public convenience init(with sections: GenericTableViewSectionModel...) {
        self.init(with: sections)
    }
    
    // MARK: - Public methods

    public func registerFor(_ tableView: UITableView) {
        for section in sections {
            section.registerFor(tableView)
        }
    }

    public func update(with sections: SectionCollection) {
        self.sections = sections
    }

    public func update(withSectionArray sections: [[TableViewRowModel]]) {
        update(with: sections.map { GenericTableViewSectionModel(with: $0) })
    }

    public func update(with sections: GenericTableViewSectionModel...) {
        self.sections = sections
    }
    
    public func setCustomDelegate(_ delegate: UITableViewDelegate) {
        customTableViewDelegate = delegate
    }
    
    public func setCustomDataSource(_ dataSource: UITableViewDataSource) {
        customTableViewDataSource = dataSource
    }
    
    public subscript(indexPath: IndexPath) -> TableViewRowModel {
        return sections[indexPath.section][indexPath.row]
    }
    
    public subscript(section: Int) -> SectionCollection.Element {
        return sections[section]
    }
}
