//
//  RealmManager.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Realm
import RealmSwift
import Alamofire
import RxSwift

typealias EmptyBlock = (Realm)->()

final class RealmManager {
    
    //
    // MARK: - Variable
    static let sharedManager = RealmManager()
    
    /// Private Realm Configuration
    /// It get secret key from Keychain
    private lazy var secrectRealmConfigure: Realm.Configuration = {
        let configuration = Realm.Configuration(encryptionKey: RealmKey.getSecrectRealmKey())
        return configuration
    }()
    
    /// Realm Default
    fileprivate var realm: Realm!
    
    //
    // MARK: - Initializer
    // Independcy injection -> For testing
    init(realm: Realm? = RealmManager.defaultRealm) {
        self.realm = realm
    }
    
    //
    // MARK: - Action
    // Fetch all
    func fetchAll<T: Object>(type: T.Type) -> Observable<Results<T>> {
        
        // Temporary
        return Observable.create { (observer) -> Disposable in
            return Disposables.create()
        }
    }
    
    /// Is Exist
    func isExist<T: Object>(type: T.Type, ID: String) -> Observable<Results<T>> {
        // Temporary
        return Observable.create { (observer) -> Disposable in
            return Disposables.create()
        }
    }
    
    /// Save
    func save(obj: Object) -> Observable<Void> {
        // Temporary
        return Observable.create { (observer) -> Disposable in
            return Disposables.create()
        }
    }
    
    /// Fetch current user
    func fetchCurrentUser() -> UserObj? {
        
        // Where user.objectId = Guest
        let results = self.realm.objects(UserObj.self).filter("\(Constants.Obj.ObjectId) = '\(Constants.Obj.User.GuestUserObjectId)'")
        
        // Get
        guard let obj = results.first else {
            return nil
        }
        
        return obj
    }
}

//
// MARK: - Write transaction helper
extension RealmManager {
    
    /// Write sync to realm-database
    /// It will write sync in current thread
    func writeSync(_ block: EmptyBlock) {
        self.realm.beginWrite()
        block(self.realm)
        try! self.realm.commitWrite()
    }
}

//
// MARK: - Private
extension RealmManager {
    
    fileprivate static var defaultRealm: Realm {
        do {
            //return try Realm(configuration: self.secrectRealmConfigure)
            return try Realm()
        } catch let error as NSError {
            // If the encryption key is wrong, `error` will say that it's an invalid database
            Logger.error("Error opening realm: \(error)")
            fatalError("Error opening realm: \(error)")
        }
    }
}
