//
//  SelectConnectionWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/11/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

//
// MARK: - Action
struct SelectConnectionAction: Action {
    var selectedConnection: DatabaseObj
    var storeType: StoreType {return .mainStore}
}

//
// MARK: - Worker
public struct SelectConnectionWorker: SyncWorker {
    
    /// Type
    typealias T = DatabaseObj
    public var selectedDb: DatabaseObj!
    
    /// Execute
    func execute() {
        let action = SelectConnectionAction(selectedConnection: self.selectedDb)
        MainStore.globalStore.dispatch(action)
    }
}
