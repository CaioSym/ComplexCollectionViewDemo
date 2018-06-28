//
//  AdvertisementCollectionCellInjector.swift
//  ComplexCollectionViewDemo
//
//  Created by Caio Freitas Sym on 6/27/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

open class AdvertisementCollectionCellInjector: BaseCollectionCellInjector<Advertisement, AdvertisementCell> {
    public override func inject(_ model: Advertisement, into cell: AdvertisementCell) {
        cell.isFeatured = model.isFeatured
        cell.subText = model.callToAction
        cell.backgroudImage = UIImage(data: model.image)
    }
}
