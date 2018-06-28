//
//  MusicAlbumCollectionCellInjector.swift
//  ComplexCollectionViewDemo
//
//  Created by Caio Freitas Sym on 6/27/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

open class MusicAlbumCollectionCellInjector: BaseCollectionCellInjector<MusicAlbum, MusicAlbumCell> {
    public override func inject(_ model: MusicAlbum, into cell: MusicAlbumCell) {
        cell.title = model.title
        cell.coverImage = UIImage(data: model.coverImage)
    }
}
