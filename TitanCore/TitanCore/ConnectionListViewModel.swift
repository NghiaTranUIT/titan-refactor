//
//  ConnectionListViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RealmSwift
import RxSwift

open class ConnectionListViewModel: BaseViewModel {

    //
    // MARK: - Variable
    fileprivate var groupConnections: List<GroupConnectionObj>!
    
    //
    // MARK: - Public
    public func fetchAllDatabase() {
        
        let worker = FetchAllGroupConnectionsWorker()
        worker.observable()
            .subscribe(onNext: {[weak self] (groups) in
                guard let `self` = self else {return}
                
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
            }, onError: { Logger.error($0) })
            .addDisposableTo(self.disposeBag)
    }

    public func selectedDatabaseObj(_ databaseObj: DatabaseObj) {
        let worker = SelectConnectionWorker(selectedDb: databaseObj)
        worker.execute()
    }
}

//
// MARK: - ViewModelAccessible
extension ConnectionListViewModel: ViewModelAccessible {
    
    public typealias Element = GroupConnectionObj
    
    public var count: Int {
        return self.groupConnections.count
    }
    
    public func item(at index: Int) -> Element {
        return self.groupConnections[index]
    }
    
    public subscript(index: Int) -> Element {
        return self.item(at: index)
    }
}

//
// MARK: - Private
extension ConnectionListViewModel {
    
    fileprivate func createDefaultGroupDatabase() {
        
        let worker = CreateNewDefaultGroupConnectionWorker()
        worker
        .observable()
        .flatMap({ (group) -> Observable<DatabaseObj> in
            return CreateNewDatabaseWorker(groupConnectionObj: group).observable()
        })
        .subscribe(onError: { Logger.error($0) })
        .addDisposableTo(self.disposeBag)
    }
    
    fileprivate func createNewDatabase(with groupObj: GroupConnectionObj) {
        
        let worker = CreateNewDatabaseWorker(groupConnectionObj: groupObj)
        worker
        .observable()
        .subscribe()
        .addDisposableTo(self.disposeBag)
    }
}
