//
//  BaseCollectionViewDataSourceProtocol.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/12/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation

//
// MARK: - Collection View Data Source
public protocol BaseCollectionViewDataSourceProtocol: CommonDataSourceProtocol {
    
    /// Get reprepresented Object
    func CommonDataSourceItemForRepresentedObjectAt(_ indexPath: IndexPath) -> NSCollectionViewItem
    
    /// Get Supplementary Element
    func CommonDataSourceViewForSupplementaryElement(of kind: String, at indexPath: IndexPath) -> NSView
    
    /// OPTIONAL
    func CommonDataSourceDidSelectedRows(at indexPaths Set<IndexPath>)
}

//
// MARK: - Default extension
extension BaseCollectionViewDataSourceProtocol {
    
    func CommonDataSourceDidSelectedRows(at indexPaths: Set<IndexPath>) {
        // Do nothing
    }
}
