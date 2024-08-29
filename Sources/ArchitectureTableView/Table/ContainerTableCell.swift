//
//  ContainerTableCell.swift
//  AbolArchitecture
//
//  Created by firdavs on 14.08.2024.
//

import UIKit
import SnapKit

public final class ContainerTableCell: UITableViewCell {
    
    public var view: UIView? {
        didSet {
            addView()
            setConstraints()
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addView() {
        guard let view else { return }
        contentView.addSubview(view)
    }
    
    private func setConstraints() {
        guard let view else { return }
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
}

public extension UIView {
    func toCell(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath,
        insets: UIEdgeInsets = .zero
    ) -> UITableViewCell {
        
        let cell = ContainerTableCell.dequeueReusableCell(
            with: tableView,
            with: indexPath
        )
        
        cell.view?.removeFromSuperview()
        cell.contentView.addSubview(self)

        self.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }

        return cell
    }
}
