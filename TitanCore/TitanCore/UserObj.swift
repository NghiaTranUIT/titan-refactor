//
//  UserObj.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RxSwift

//
// MARK: - UserObj
final class UserObj: BaseModel {
    
    //
    // MARK: - Variable
    dynamic var username = "guest"
    dynamic var isGuest: Bool = true
    let groupConnections = List<GroupConnectionObj>()
    
    //
    // MARK: - Current User
    private struct Static {
        static var instance: UserObj!
    }
    
    /// Share instance
    class var currentUser : UserObj {
        
        // LOCK
        objc_sync_enter(self)
        defer {objc_sync_exit(self)}
        
        // Executing
        if Static.instance == nil {
            
            Logger.info("---Fetching Current User---")
            
            // Get from disk
            // Sync
            let userObj = RealmManager.sharedManager.fetchCurrentUser()
            
            // Turn to currentUsr
            if let userObj = userObj {
                Static.instance = userObj
                return Static.instance
            }
            
            // Create Guest User
            let guestUser = UserObj.guestUser()
            Static.instance = guestUser
            
            // Save
            RealmManager.sharedManager
                .save(obj: Static.instance)
                .subscribe().addDisposableTo(DisposeBag())
        }
        
        return Static.instance
    }
    
    override class func objectForMapping(map: Map) -> BaseMappable? {
        return UserObj()
    }
}

//
// MARK: - Private
extension UserObj {
    
    /// Init GUEST User
    fileprivate class func guestUser() -> UserObj {
        let guestUser = UserObj()
        guestUser.objectId = Constants.Obj.User.GuestUserObjectId
        guestUser.isGuest = true
        return guestUser
    }
}
