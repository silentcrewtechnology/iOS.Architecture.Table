//
//  TableViewBuilder.swift
//  
//
//  Created by user on 31.05.2024.
//

import Architecture

public struct TableViewBuilder: BuilderProtocol {
    public typealias V = TableView
    public typealias U = TableViewUpdater
    
    // MARK: - Public properties
    
    public var view: TableView
    public var viewUpdater: TableViewUpdater
    
    // MARK: - Life cycle
    
    public init(with viewProperties: TableView.ViewProperties) {
        view = TableView(viewProperties: viewProperties)
        viewUpdater = TableViewUpdater(
            viewProperties: viewProperties,
            update: view.update
        )
        
        view.layoutIfNeeded()
    }
}
