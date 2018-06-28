//
//  BaseCollectionAdapter.swift
//  SkyScannerApp
//
//  Created by Caio Freitas Sym on 5/12/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

public protocol CollectionAdapterType {
    func attach(collectionView: UICollectionView?)
}

// Base Adapter implementation for handling `UICollectionView`s
open class BaseCollectionAdapter<T>: BaseAdapter<T>, CollectionAdapterType, UICollectionViewDelegate,
        UICollectionViewDataSource {
    /// The managed collectionView
    private(set) weak var collectionView: UICollectionView?
    
    /// Whether data is being loaded
    override var isLoading: Bool {
        didSet {
            collectionView?.isUserInteractionEnabled = !isLoading
            collectionView?.reloadData()
        }
    }
    
    override func update(items: [T]) {
        super.update(items: items)
        self.collectionView?.reloadData()
    }
    
    /// Attaches itself to a UICollectionView by becoming its delegate and dataSource
    open func attach(collectionView: UICollectionView?) {
        self.collectionView = collectionView
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        fatalError("collectionView(collectionView:numberOfItemsInSection) has not been implemented")
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("collectionView(collectionView:cellForItemAt) has not been implemented")
    }
}
