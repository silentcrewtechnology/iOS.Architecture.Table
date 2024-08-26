//
//  SectionRowModelService.swift
//
//
//  Created by user on 26.08.2024.
//

import UIKit
import DesignSystem

public struct SectionRowModelService {
    
    public init() { }
    
    public func createSections(
        from rows: [DSRowModel],
        rowsHeight: CGFloat? = nil,
        cellBackgroundColor: UIColor = .white
    ) -> [SectionModel] {
        return rows.map { row in
            let cell = DSCreationRowsViewService().createViewRowWithBlocks(
                leading: row.leading,
                center: row.center,
                trailing: row.trailing,
                centralBlockAlignment: row.centralBlockAlignment
            )
            let cellModel = CellModel(
                view: cell,
                selectionStyle: .none,
                height: rowsHeight,
                didTap: nil,
                backgroundColor: cellBackgroundColor
            )
            
            return SectionModel(cells: [cellModel])
        }
    }
}
