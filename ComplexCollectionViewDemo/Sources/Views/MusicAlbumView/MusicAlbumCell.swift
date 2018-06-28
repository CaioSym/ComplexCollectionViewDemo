//
//  MusicAlbumCell.swift
//  ComplexColectionViewDemo
//
//  Created by Caio Freitas Sym on 6/27/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

public class MusicAlbumCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var coverImageView: UIImageView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentViewInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentViewInit()
    }
    
    private func contentViewInit() {
        let contentView = R.nib.musicAlbumCell.firstView(owner: self, options: nil)!
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // init static definitions
        titleLabel?.textColor = Theme.primaryColor
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
    
    @IBInspectable
    var coverImage: UIImage? {
        get {
            return coverImageView?.image
        }
        set {
            coverImageView?.image = newValue
        }
    }
}
