//
//  BaseCollectionViewDataSource.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import Cocoa

open class BaseCollectionViewDataSource: NSObject {
    
    //
    // MARK: - Variable
    public weak var delegate: BaseCollectionViewDataSourceProtocol?
    public private(set) var collectionView: NSCollectionView!
    
    //
    // MARK: - Initialization
    public init(collectionView: NSCollectionView) {
        super.init()
        
        self.collectionView = collectionView
        self.initCollectionView()
    }
}

//
// MARK: - Private
extension BaseCollectionViewDataSource {
    
    fileprivate func initCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

//
// MARK: - NSCollectionViewDataSource
extension BaseCollectionViewDataSource: NSCollectionViewDataSource {
    
    public func numberOfSections(in collectionView: NSCollectionView) -> Int {
        guard let delegate = self.delegate else {
            return 0
        }
        
        return delegate.CommonDataSourceNumberOfSection()
    }
    
    public func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = self.delegate else {
            return 0
        }
        
        return delegate.CommonDataSourceNumberOfItem(at: section)
    }
    
    public func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let delegate = self.delegate else {
            return NSCollectionViewItem()
        }
        
        return delegate.CommonDataSourceItemForRepresentedObjectAt(indexPath)
    }
    
    public func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        guard let delegate = self.delegate else {
            return NSView()
        }
        
        return delegate.CommonDataSourceViewForSupplementaryElement(of: kind, at: indexPath)
    }
}

//
// MARK: - NSCollectionViewDelegate
extension BaseCollectionViewDataSource: NSCollectionViewDelegate {
    
    public func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.CommonDataSourceDidSelectedRows(at: indexPaths)
    }
}
