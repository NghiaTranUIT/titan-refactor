//
//  BaseViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/3/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import Realm

//
// MARK: - BaseModel
open class BaseModel: Object {
    
    //
    // MARK: - Variable
    dynamic var createdAt: Date! = Date()
    dynamic var updatedAt: Date! = Date()
    
    /// Make objectId is primary key
    /// Obj must have primary key to support "Update" depend on primary key
    /// https://realm.io/docs/swift/latest/#updating-objects
    override open static func primaryKey() -> String? {
        return ""
    }
    
    //
    // MARK: - Mapping
    public class func objectForMapping(map: Map) -> BaseMappable? {
        return BaseModel()
    }
    
    public func mapping(map: Map) {
        
    }
}

//
// MARK: - StaticMappable
extension BaseModel: StaticMappable {}
