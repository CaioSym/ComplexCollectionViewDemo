//
//  SingleCellCollectionCellViewAdapter.swift
//  ComplexColectionViewDemo
//
//  Created by Caio Freitas Sym on 6/27/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

private let cellReuseIdentifier = "reusableCell"

open class SingleCellCollectionCellViewAdapter<Model, Cell: UICollectionViewCell>: BaseCollectionAdapter<Model>,
        UICollectionViewDelegateFlowLayout {
    
    private let injector: BaseCollectionCellInjector<Model, Cell>
    private let cellWidth: CGFloat
    public init(injector: BaseCollectionCellInjector<Model, Cell>, cellWidth: CGFloat) {
        self.injector = injector
        self.cellWidth = cellWidth
        super.init()
    }
    
    open override func attach(collectionView: UICollectionView?) {
        super.attach(collectionView: collectionView)
        collectionView?.register(Cell.self, forCellWithReuseIdentifier: cellReuseIdentifier)

    }
    
    public override func collectionView(_ collectionView: UICollectionView,
                                        numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView,
                                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! Cell
        //swiftlint:enable force_cast
        injector.inject(items[indexPath.row], into: cell)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: collectionView.bounds.size.height)
    }
}
