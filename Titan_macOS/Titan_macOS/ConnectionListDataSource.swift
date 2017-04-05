//
//  ConnectionListDataSource.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class ConnectionListDataSource: BaseTableViewDataSource {
    
    //
    // MARK: - Init
    override init(tableView: NSTableView) {
        super.init(tableView: tableView)
        
        self.initTableView()
    }

}

//
// MARK: - Private
extension ConnectionListDataSource {
    
    fileprivate func initTableView() {
    
    }
}
