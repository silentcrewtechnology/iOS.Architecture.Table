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
    
    public func createSection(
        from rows: [DSRowModel],
        rowsHeight: CGFloat? = nil,
        cellBackgroundColor: UIColor = .white
    ) -> SectionModel {
        let cellModels = rows.map { row in
            let rowView = DSCreationRowsViewService().createViewRowWithBlocks(
                leading: row.leading,
                center: row.center,
                trailing: row.trailing,
                centralBlockAlignment: row.centralBlockAlignment,
                verticalAlignment: row.verticalAlignment,
                margins: row.margings
            )
            let cellModel = CellModel(
                view: rowView,
                selectionStyle: row.cellSelectionStyle,
                height: rowsHeight ?? row.height,
                didTap: row.didTap,
                backgroundColor: row.backgroundColor ?? cellBackgroundColor
            )
            
            return cellModel
        }
        
        return SectionModel(cells: cellModels)
    }
}
