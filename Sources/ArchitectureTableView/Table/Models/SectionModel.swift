import UIKit

public struct SectionModel {
    public var headerView: UIView? = nil
    public var footerView: UIView? = nil
    public var headerHeight: CGFloat
    public var footerHeight: CGFloat
    public let cells: [CellModel]
    
    public init(
        headerView: UIView? = nil,
        footerView: UIView? = nil,
        headerHeight: CGFloat = 0,
        footerHeight: CGFloat = 0,
        cells: [CellModel]
    ) {
        self.headerView = headerView
        self.footerView = footerView
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
        self.cells = cells
    }
}


