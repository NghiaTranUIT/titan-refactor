//
//  BaseModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import ObjectMapper
import RealmSwift
import Realm

//
// MARK: - BaseModel
open class BaseModel: Object {
    
    //
    // MARK: - Variable
    dynamic var
    objectId: String! = UUID.shortUUID()
    dynamic var createdAt: Date! = Date()
    dynamic var updatedAt: Date! = Date()
    
    /// Make objectId is primary key
    /// Obj must have primary key to support "Update" depend on primary key
    /// https://realm.io/docs/swift/latest/#updating-objects
    override open static func primaryKey() -> String? {
        return Constants.Obj.ObjectId
    }
    
    //
    // MARK: - Mapping
    public class func objectForMapping(map: Map) -> BaseMappable? {
        return BaseModel()
    }
    
    public func mapping(map: Map) {
        self.objectId <- map[Constants.Obj.ObjectId]
        self.createdAt <- (map[Constants.Obj.CreatedAt], APIDateTransform())
        self.updatedAt <- (map[Constants.Obj.UpdatedAt], APIDateTransform())
    }
}

//
// MARK: - StaticMappable
extension BaseModel: StaticMappable {}