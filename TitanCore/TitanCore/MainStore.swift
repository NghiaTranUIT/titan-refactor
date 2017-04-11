//
//  MainStore.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa

public enum StoreType {
    case mainStore
    case connectionStore
}

open class MainStore: ReduxStore {

    //
    // MARK: - Variable
    public var storyType: StoreType {
        return .mainStore
    }
    
    //
    // MARK: - Sub store
    public var connectionStore: ConnectionStore?
    
    //
    // MARK: - Dispatch Action
    public func handleAction(_ action: Action) {
        
        // Get sub store
        let subStore = self.subStoreWithType(action)
        
        // Dispatch
        subStore.dispatchAction(action)
    }
    
    public func dispatchAction(_ action: Action) {
        
    }
}

//
// MARK: - Private
extension MainStore {
    
    // Get store with type
    func subStoreWithType(_ action: Action) -> ReduxStore {
        
        switch action.storeType {
        case .mainStore:
            return self
        case .connectionStore:
            
            // Init
            guard let store = self.connectionStore else {
                self.connectionStore = ConnectionStore()
                return self.connectionStore!
            }
            
            return store
        }
    }
}
