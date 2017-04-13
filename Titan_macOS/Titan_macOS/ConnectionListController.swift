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
    @IBOutlet weak var collectionView: NSCollectionView!
    
    //
    // MARK: - Variable
    fileprivate var dataSource: ConnectionListDataSource!
    fileprivate var viewModel: ConnectionListViewModel!
    
    //
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
        self.initViewModel()
        self.initDataSource()
        self.binding()

        // Fetch connection
        self.viewModel.fetchAllDatabase()
    }
    
}

//
// MARK: - Private
extension ConnectionListController {
    
    fileprivate func initCommon() {
        
    }
    
    fileprivate func initDataSource() {
        self.dataSource = ConnectionListDataSource(collectionView: self.collectionView)
        self.dataSource.delegate = self
    }
    
    fileprivate func initViewModel() {
        self.viewModel = ConnectionListViewModel()
    }
    
    fileprivate func binding() {
        
        // Reload data
        
        MainStore.globalStore.connectionStore.groupConnections.asObservable().subscribe(onNext: { _ in
            self.collectionView.reloadData()
        })
        .addDisposableTo(self.disposeBase)
 
 
    }
}

//
// MARK: - CommonDataSourceProtocol
extension ConnectionListController: BaseCollectionViewDataSourceProtocol {

    // Number of item
    func CommonDataSourceNumberOfItem(at section: Int) -> Int {
        let groupObj = self.viewModel[section]
        return groupObj.databases.count
    }
    
    // Number of section
    func CommonDataSourceNumberOfSection() -> Int {
        return self.viewModel.count
    }
    
    // Item at index path
    func CommonDataSourceItem(at indexPath: IndexPath) -> BaseModel {
        return self.viewModel[indexPath.section]
    }
}

