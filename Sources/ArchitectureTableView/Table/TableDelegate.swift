//
//  TableDelegate.swift
//  AbolArchitecture
//
//  Created by firdavs on 14.08.2024.
//

import UIKit

public final class TableDelegate: NSObject, UITableViewDelegate {
    
    private var sections: [SectionModel] = []

    public func update(with sections: [SectionModel]) {
        self.sections = sections
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].cells[indexPath.row]
        row.didTap?(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].cells[indexPath.row]
        return row.height ?? UITableView.automaticDimension
    }
}

