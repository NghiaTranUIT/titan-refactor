//
//  ConnectionStore.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RealmSwift

//
// MARK: - ConnectionStore
open class ConnectionStore: ReduxStore {
    
    //
    // MARK: - Variable
    public var groupConnection: List<GroupConnectionObj> = List<GroupConnectionObj>()
    
    // Story type
    public var storyType: StoreType {
        return .connectionStore
    }
    
    //
    // MARK: - Disaptch
    public func handleAction(_ action: Action) {
        
        switch action {
        case let action as UpdateGroupConnectionAction:
            self.groupConnection = action.groupConnection
            
        case let _ as FetchAllGroupConnectionsAction:
            
            // Get from current User
            self.groupConnection = UserObj.currentUser.groupConnections
            
        default: break
            // Do nothing
        }
    }
}
