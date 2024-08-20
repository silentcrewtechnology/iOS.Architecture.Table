import UIKit

public struct SectionModel {
    public var headerView: UIView? = nil
    public var footerView: UIView? = nil
    public var headerHeight: CGFloat? = nil
    public var footerHeight: CGFloat? = nil
    public let cells: [CellModel]
    
    public init(
        headerView: UIView? = nil,
        footerView: UIView? = nil,
        headerHeight: CGFloat? = nil,
        footerHeight: CGFloat? = nil,
        cells: [CellModel]
    ) {
        self.headerView = headerView
        self.footerView = footerView
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
        self.cells = cells
    }
}


