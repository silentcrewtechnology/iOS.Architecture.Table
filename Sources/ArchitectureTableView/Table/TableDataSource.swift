//
//  TableDataSource.swift
//  AbolArchitecture
//
//  Created by firdavs on 14.08.2024.
//

import DesignSystem
import Components
import Extensions
import Architecture
import UIKit

public final class TableDataSource: NSObject, UITableViewDataSource {
    
    private var sections: [SectionModel] = []

    public func update(with sections: [SectionModel]) {
        self.sections = sections
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsCount = sections[section].cells.count
        return rowsCount
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let row = section.cells[indexPath.row]
        let cell = row.view.toCell(tableView, cellForRowAt: indexPath)
        cell.selectionStyle = row.selectionStyle
        return cell
    }
}
