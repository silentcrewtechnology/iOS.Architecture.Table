//
//  TableViewUpdater.swift
//  
//
//  Created by user on 04.06.2024.
//

import Architecture
import UIKit

final public class TableViewUpdater: ViewUpdater<TableView> {
    
    //MARK: - Public properties
    
    public enum State {
        case updateViewProperties(TableView.ViewProperties)
        case reloadData
    }
    
    public var state: State? {
        didSet { self.stateManager() }
    }
    
    public var viewProperties: TableView.ViewProperties
    
    // MARK: - Life cycle
    
    override init(
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
        guard let state = self.state else { return }
        
        switch state {
        case .updateViewProperties(let viewProperties):
            self.viewProperties = viewProperties
            update(viewProperties)
        case .reloadData:
            update(viewProperties)
        }
    }
}
