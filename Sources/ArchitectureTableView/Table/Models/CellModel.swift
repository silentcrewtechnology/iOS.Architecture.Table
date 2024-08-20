import UIKit

public struct CellModel {
    public let view: UIView
    public let selectionStyle: UITableViewCell.SelectionStyle
    public let height: CGFloat?
    public let didTap: ((IndexPath) -> Void)? = nil
    
    public init(
        view: UIView,
        selectionStyle: UITableViewCell.SelectionStyle = .gray,
        height: CGFloat?,
        didTap: ((IndexPath) -> Void)? = nil
    ) {
        self.view = view
        self.selectionStyle = selectionStyle
        self.height = height
        self.didTap = didTap
    }
}
