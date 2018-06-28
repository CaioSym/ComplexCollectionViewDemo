//
//  BaseCollectionCellInjector.swift
//  ComplexCollectionViewDemo
//
//  Created by Caio Freitas Sym on 6/27/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

open class BaseCollectionCellInjector<Model, Cell: UICollectionViewCell> {
    public func inject(_ model: Model, into cell: Cell) {
        fatalError("inject(:into) has not been implemented")
    }
}
