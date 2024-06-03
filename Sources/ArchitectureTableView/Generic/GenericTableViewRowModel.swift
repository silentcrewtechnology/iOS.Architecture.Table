//
//  GenericTableViewRowModel.swift
//
//
//  Created by user on 03.06.2024.
//

import UIKit

public class GenericTableViewRowModel<T: UITableViewCell>: TableViewRowModel {
    
    // MARK: - Life cycle
    
    public init(
        with cellType: T.Type,
        configuration configurationBlock: ((T, IndexPath) -> Void)?,
        andAction actionBlock: ActionBlock? = nil,
        initializesFromNib: Bool
    ) {
        super.init(
            with: T.self,
            configuration: { (cell, indexPath) in
                guard let cell = cell as? T else { return }
                
                configurationBlock?(cell, indexPath)
            },
            andAction: actionBlock,
            initializesFromNib: initializesFromNib
        )
    }
    
    public convenience init(
        configuration configurationBlock: ((T, IndexPath) -> Void)?,
        andAction actionBlock: ActionBlock? = nil,
        initializesFromNib: Bool
    ) {
        self.init(
            with: T.self,
            configuration: configurationBlock,
            andAction: actionBlock,
            initializesFromNib: initializesFromNib
        )
    }
}
