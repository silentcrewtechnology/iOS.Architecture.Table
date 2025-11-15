//
//  ContainerTableCell.swift
//  AbolArchitecture
//
//  Created by firdavs on 14.08.2024.
//

import UIKit
import SnapKit

public final class ContainerTableCell: UITableViewCell {
    
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
        
        cell.contentView.addSubview(self)
        
        snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets).priority(999)
        }
        
        return cell
    }
}
