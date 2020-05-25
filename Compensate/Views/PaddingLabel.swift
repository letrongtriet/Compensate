//
//  PaddingLabel.swift
//  Compensate
//
//  Created on 25.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    var topInset: CGFloat = 10
    var bottomInset: CGFloat = 10
    var leftInset: CGFloat = 10
    var rightInset: CGFloat = 10
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
