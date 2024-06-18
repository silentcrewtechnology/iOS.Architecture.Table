import UIKit
import Architecture

public final class TableViewVCUpdater: ViewUpdater<TableViewVC> {
    
    // MARK: - Public properties
    
    public enum State {
        case updateViewProperties(TableViewVC.ViewProperties)
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
        }
        
        update(viewProperties)
    }
}
