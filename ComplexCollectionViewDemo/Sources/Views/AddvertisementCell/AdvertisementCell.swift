//
//  AdvertisementCell.swift
//  ComplexColectionViewDemo
//
//  Created by Caio Freitas Sym on 6/27/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

public class AdvertisementCell: UICollectionViewCell {
    
    @IBOutlet private weak var advertisementImageView: UIImageView?
    @IBOutlet private weak var featuredLabel: OverlayBannerLabel?
    @IBOutlet private weak var subTextLabel: OverlayBannerLabel?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentViewInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentViewInit()
    }
    
    private func contentViewInit() {
        let contentView = R.nib.advertisementCell.firstView(owner: self, options: nil)!
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // init static definitions
        featuredLabel?.text = "Featured"
        
        featuredLabel?.textColor = Theme.primaryColor
        featuredLabel?.backgroundColor = Theme.overlayBackgroundColor
        featuredLabel?.alpha = Theme.overlayAlpha
        
        subTextLabel?.textColor = Theme.primaryColor
        subTextLabel?.backgroundColor = Theme.overlayBackgroundColor
        subTextLabel?.alpha = Theme.overlayAlpha
        
        overlaysCornerRadius = CGFloat(10.5)
    }
    
    @IBInspectable
    var isFeatured: Bool {
        get {
            return !(featuredLabel?.isHidden ?? true)
        }
        set {
            featuredLabel?.isHidden = !newValue
        }
    }
    
    @IBInspectable
    var subText: String? {
        get {
            return subTextLabel?.text
        }
        set {
            subTextLabel?.text = newValue
        }
    }
    
    @IBInspectable
    var backgroudImage: UIImage? {
        get {
            return advertisementImageView?.image
        }
        set {
            advertisementImageView?.image = newValue
        }
    }
    
    var overlaysCornerRadius: CGFloat {
        get {
            return (featuredLabel?.cornerRadius) ?? CGFloat(0)
        }
        set {
            featuredLabel?.layer.cornerRadius = newValue
            subTextLabel?.layer.cornerRadius = newValue
        }
    }
}
