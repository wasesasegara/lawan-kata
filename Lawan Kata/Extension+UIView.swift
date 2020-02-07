//
//  Extension+UIView.swift
//  Lawan Kata
//
//  Created by Bisma S Wasesasegara on 07/02/20.
//  Copyright © 2020 Bisma S Wasesasegara. All rights reserved.
//

import UIKit

extension UIView {

    func width() -> CGFloat {
        return bounds.width
    }
    
    func height() -> CGFloat {
        return bounds.height
    }
    
    func safeWidth() -> (min: CGFloat, max: CGFloat) {
        return (CGFloat(50), width() - 2 * Constants.safeHorizontalMargin)
    }
    
    func safeHeight() -> (min: CGFloat, max: CGFloat) {
        return (CGFloat(50), height() - 2 * Constants.safeVerticalMargin)
    }

}
