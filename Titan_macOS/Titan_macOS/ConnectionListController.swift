//
//  ConnectionListController.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

class ConnectionListController: BaseViewController {

    //
    // MARK: - OUTLET
    @IBOutlet weak var tableView: NSTableView!
    
    //
    // MARK: - Variable
    fileprivate lazy var dataSource: ConnectionListDataSource!
    fileprivate var viewModel: ConnectionListViewModel!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
        self.initDataSource()
        self.initViewModel()
        
        // Fetch connection
        self.viewModel.fetchConnection()
    }
    
}

//
// MARK: - Private
extension ConnectionListController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initDataSource() -> ConnectionListDataSource {
        let dataSource = ConnectionListDataSource(tableView: self.tableView)
        dataSource.delegate = self
        return dataSource
    }
    
    fileprivate func initViewModel() {
        self.viewModel = ConnectionListViewModel()
    }
}

//
// MARK: - CommonDataSourceProtocol
extension ConnectionListController: CommonDataSourceProtocol {

    // Number of item
    func CommonDataSourceNumberOfItem(at section: Int) -> Int {
        return 0
    }
    
    // Number of section
    func CommonDataSourceNumberOfSection() -> Int {
        return 1
    }
    
    // Item at index path
    func CommonDataSourceItem(at indexPath: IndexPath) -> BaseModel {
        return BaseModel()
    }
}
 
