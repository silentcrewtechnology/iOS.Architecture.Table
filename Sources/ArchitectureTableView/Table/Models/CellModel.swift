import UIKit

public struct CellModel {
    public let view: UIView
    public let selectionStyle: UITableViewCell.SelectionStyle
    public let height: CGFloat?
    public let didTap: ((IndexPath) -> Void)?
    public let insets: UIEdgeInsets
    public let backgroundColor: UIColor
    
    public init(
        view: UIView,
        selectionStyle: UITableViewCell.SelectionStyle = .gray,
        height: CGFloat?,
        didTap: ((IndexPath) -> Void)? = nil,
        insets: UIEdgeInsets = .zero,
        backgroundColor: UIColor = .white
    ) {
        self.view = view
        self.selectionStyle = selectionStyle
        self.height = height
        self.didTap = didTap
        self.insets = insets
        self.backgroundColor = backgroundColor
    }
}
