//
//  ConnectionListViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RealmSwift

open class ConnectionListViewModel: BaseViewModel {

    //
    // MARK: - Variable
    var groupConnections: List<GroupConnectionObj>!
    
    //
    // MARK: - Public
    public func fetchAllDatabase() {
        
        let worker = FetchAllGroupConnectionsWorker()
        worker.observable()
            .subscribe(onNext: { (groups) in
                // Create default
                if groups.count == 0 {
                    self.createDefaultGroupDatabase()
                    return
                }
                
                // Have Group, but no database
                if groups.count == 1 && groups.first!.databases.count == 0 {
                    self.createNewDatabase(with: groups.first!)
                    return
                }
                
                // If have group, have databases -> Select first database
                if groups.count >= 1 && groups.first!.databases.count > 0 {
                    self.selectedDatabaseObj(groups.first!.databases.first!)
                    return
                }
            }, onError: { (error) in
                
            })
            .addDisposableTo(self.disposeBag)
    }

    public func selectedDatabaseObj(_ databaseObj: DatabaseObj) {
        
    }
}

//
// MARK: - Private
extension ConnectionListViewModel {
    
    fileprivate func createDefaultGroupDatabase() {
        
        let worker = CreateNewDefaultGroupConnectionWorker()
        worker
            .execute()
            .thenOnMainTheard(execute: { group -> Promise<DatabaseObj> in
                return CreateNewDatabaseWorker(groupConnectionObj: group)
                    .execute()
            })
            .catch(execute: {[unowned self] error in
                self.output.presentError(error as NSError)
            })
    }
    
    fileprivate func createNewDatabase(with groupObj: GroupConnectionObj) {
        
        let worker = CreateNewDatabaseWorker(groupConnectionObj: groupObj)
        worker
            .execute()
            .then(execute: { databaseObj -> Void in
                Logger.debug(databaseObj)
            }).catch(execute: { error in
                Logger.error(error)
            })
    }
}
