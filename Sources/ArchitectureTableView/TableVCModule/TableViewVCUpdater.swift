//
//  TableViewVCUpdater.swift
//  
//
//  Created by user on 31.05.2024.
//

import UIKit
import Architecture
import DesignSystem

public final class TableViewVCUpdater: ViewUpdater<TableViewVC> {
    
    // MARK: - Public properties
    
    public enum State {
        case updateViewProperties(TableViewVC.ViewProperties)
        case updateConfirmButtonState(ButtonViewStyle.State)
        case updateActivityIndicator(Bool)
    }
    
    public var state: State? {
        didSet { stateManager() }
    }
    
    // MARK: - Private properties
    
    private var viewProperties: TableViewVC.ViewProperties
    
    // MARK: - Life cycle
    
    override public init(
        viewProperties: TableViewVC.ViewProperties,
        update: @escaping Closure<TableViewVC.ViewProperties>
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
        case .updateViewProperties(let viewProperties):
            self.viewProperties = viewProperties
        case .updateConfirmButtonState(let confirmButtonState):
            viewProperties.confirmButtonState = confirmButtonState
        case .updateActivityIndicator(let shouldShowActivityIndicator):
            viewProperties.shouldShowActivityIndicator = shouldShowActivityIndicator
        }
        
        update(viewProperties)
    }
}
