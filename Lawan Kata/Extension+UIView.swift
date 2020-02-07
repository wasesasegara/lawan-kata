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
        return (CGFloat(50), width() * Constants.maxSafeSize)
    }
    
    func safeHeight() -> (min: CGFloat, max: CGFloat) {
        return (CGFloat(50), height() * Constants.maxSafeSize)
    }
    
    func sizeDiff(view: UIView) -> (width: CGFloat, height: CGFloat) {
        return (safeWidth().max - safeWidth().min, safeHeight().max - safeHeight().min - Constants.bottomPoint)
    }

}
