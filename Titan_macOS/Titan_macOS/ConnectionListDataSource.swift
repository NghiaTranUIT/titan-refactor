//
//  ConnectionListDataSource.swift
//  Titan_macOS
//
//  Created by Nghia Tran on 4/5/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import TitanCore

//
// MARK: - ConnectionListDataSource
class ConnectionListDataSource: BaseCollectionViewDataSource {
    
    //
    // MARK: - Variable
    
    //
    // MARK: - Init
    override init(collectionView: NSCollectionView) {
        super.init(collectionView: collectionView)
        
        self.setupCollectionView()
    }
}

//
// MARK: - Private
extension ConnectionListDataSource {
    
    fileprivate func setupCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Register
        self.collectionView.registerCell(ConnectionCell.self)
        self.collectionView.registerSupplementary(ConnectionGroupCell.self, kind: NSCollectionElementKindSectionHeader)
        
        // Flow layout
        let flowLayout = NSCollectionViewFlowLayout()
        let width = collectionView.frame.size.width
        flowLayout.itemSize = CGSize(width: 250, height: 31)
        flowLayout.sectionInset = NSEdgeInsetsMake(0, 0, 6, 0)
        flowLayout.headerReferenceSize = CGSize(width: width, height: 31)
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.sectionFootersPinToVisibleBounds = false
        self.collectionView.collectionViewLayout = flowLayout
        
        // Reload
        self.collectionView.reloadData()
    }
}
