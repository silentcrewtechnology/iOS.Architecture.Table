//
//  TableViewVCBuilder.swift
//  
//
//  Created by user on 31.05.2024.
//

import Architecture

public struct TableViewVCBuilder: BuilderProtocol {
    public typealias V = TableViewVC
    public typealias U = TableViewVCUpdater
    
    // MARK: - Public properties
    
    public var view: TableViewVC
    public var viewUpdater: TableViewVCUpdater
    
    // MARK: - Life cycle
    
    public init(with viewProperties: TableViewVC.ViewProperties) {
        view = TableViewVC(viewProperties: viewProperties)
        viewUpdater = TableViewVCUpdater(
            viewProperties: viewProperties,
            update: view.update
        )
        
        view.loadViewIfNeeded()
    }
}
