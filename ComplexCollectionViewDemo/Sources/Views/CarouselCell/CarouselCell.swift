//
//  CarouselCell.swift
//  ComplexColectionViewDemo
//
//  Created by Caio Freitas Sym on 6/27/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

class CarouselCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var collectionView: UICollectionView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentViewInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentViewInit()
    }
    
    private func contentViewInit() {
        let contentView = R.nib.carouselCell.firstView(owner: self, options: nil)!
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // init static definitions
        titleLabel?.textColor = Theme.primaryColor
        // FIX-ME: For some reason collection view inside a collection view does not properly propagate
        //bg color. Needs investigation.
        collectionView?.backgroundColor = Theme.backgroundColor
    }
    
    @IBInspectable
    var title: String? {
        get {
            return titleLabel?.text
        }
        set {
            titleLabel?.text = newValue
        }
    }
    
    var contentsAdapter: CollectionAdapterType? {
        didSet {
            contentsAdapter?.attach(collectionView: collectionView)
        }
    }
}
