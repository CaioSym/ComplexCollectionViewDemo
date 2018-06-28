//
//  OverlayBannerLabel.swift
//  ComplexColectionViewDemo
//
//  Created by Caio Freitas Sym on 6/27/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

class OverlayBannerLabel: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var label: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentViewInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentViewInit()
    }
    
    private func contentViewInit() {
        _ = R.nib.overlayBannerLabel.firstView(owner: self, options: nil)!
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBInspectable
    var text: String? {
        get {
            return label?.text
        }
        set {
            label?.text = newValue
        }
    }
    
    var textColor: UIColor {
        get {
            return (label?.textColor) ?? Theme.primaryColor
        }
        set {
            label?.textColor = newValue
        }
    }
}
