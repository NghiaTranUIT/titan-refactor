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
import RxCocoa

public protocol ConnectionListViewModelInput {
    var fetchAllDatabasePublisher: PublishSubject<Void> { get }
}

public protocol ConnectionListViewModelOutput {
    var isLoading: Driver<Bool> { get }
    var groupConnectionsVariable: Variable<List<GroupConnectionObj>> { get }
}

public protocol ConnectionListViewModelType {
    var input: ConnectionListViewModelInput { get }
    var output: ConnectionListViewModelOutput { get }
}


//
// MARK: - ConnectionListViewModel
open class ConnectionListViewModel: BaseViewModel, ConnectionListViewModelType, ConnectionListViewModelInput, ConnectionListViewModelOutput {

    //
    // MARK: - View Model Type
    public var output: ConnectionListViewModelOutput { return self }
    public var input: ConnectionListViewModelInput { return self }
    
    //
    // MARK: - Input
    public var fetchAllDatabasePublisher = PublishSubject<Void>()
    
    //
    // MARK: - Outut
    fileprivate var _isLoading = ActivityIndicator()
    public var isLoading: Driver<Bool> { return self._isLoading.asDriver()}
    public var groupConnectionsVariable: Variable<List<GroupConnectionObj>> {
        return MainStore.globalStore.connectionStore.groupConnections
    }
    
    //
    // MARK: - Init
    public override init() {
        super.init()
        
        // Binding
        self.initBinding()
    }
    
    fileprivate func initBinding() {
        
        // Fetch database
        self.isLoading
            .asObservable()
            .sample(self.fetchAllDatabasePublisher)
            .flatMap { _isLoading -> Observable<Void> in
                if _isLoading.hashValue == 0 {
                    return self.fetchDatabaseObserve()
                }
                return Observable.empty()
        }.subscribe()
        .addDisposableTo(self.disposeBag)
    }
    
    //
    // MARK: - Public
    public func selectedDatabaseObj(_ databaseObj: DatabaseObj) -> Observable<Void> {
        let worker = SelectConnectionWorker(selectedDb: databaseObj)
        return worker.observable().map({ (_) -> Void in
            return
        })
    }
}

//
// MARK: - ViewModelAccessible
extension ConnectionListViewModel: ViewModelAccessible {
    
    public typealias Element = GroupConnectionObj
    
    public var count: Int {
        return self.groupConnectionsVariable.value.count
    }
    
    public func item(at index: Int) -> Element {
        return self.groupConnectionsVariable.value[index]
    }
    
    public subscript(index: Int) -> Element {
        return self.item(at: index)
    }
}

//
// MARK: - Private
extension ConnectionListViewModel {
    
    fileprivate func fetchDatabaseObserve() -> Observable<Void> {
        let worker = FetchAllGroupConnectionsWorker()
        return worker.observable().trackActivity(self._isLoading)
            .flatMap { (groups) -> Observable<Void> in
                
                // Create default
                if groups.count == 0 {
                    return self.createDefaultGroupDatabase()
                }
                
                // Have Group, but no database
                if groups.count == 1 && groups.first!.databases.count == 0 {
                    return self.createNewDatabase(with: groups.first!)
                }
                
                // If have group, have databases -> Select first database
                if groups.count >= 1 && groups.first!.databases.count > 0 {
                    return self.selectedDatabaseObj(groups.first!.databases.first!)
                }
                
                return Observable.empty()
        }
    }
    
    fileprivate func createDefaultGroupDatabase() -> Observable<Void> {
    
        let worker = CreateNewDefaultGroupConnectionWorker()
        return worker
        .observable()
        .flatMap({ (group) -> Observable<Void> in
            return CreateNewDatabaseWorker(groupConnectionObj: group).observable()
            .map({ (_) -> Void in
                return
            })
        })
    }
    
    fileprivate func createNewDatabase(with groupObj: GroupConnectionObj) -> Observable<Void> {
        
        let worker = CreateNewDatabaseWorker(groupConnectionObj: groupObj)
        return worker
        .observable()
        .map({ _ -> Void in
            return
        })
    }
}
