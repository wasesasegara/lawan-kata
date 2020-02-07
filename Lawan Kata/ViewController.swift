//
//  ViewController.swift
//  Lawan Kata
//
//  Created by Bisma S Wasesasegara on 06/02/20.
//  Copyright © 2020 Bisma S Wasesasegara. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private var dif: CGFloat = 0
    private var origin: CGFloat = 0
    private var scale: CGFloat = 1
    private var width: CGFloat = 128
    private var height: CGFloat = 128
    
    @IBOutlet weak var viewObject: UIView!
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupObject()
    }
    
    private func setupObject() {
        guard let object = viewObject else { return }
        object.frame = CGRect(origin: .zero, size: CGSize(width: Constants.minSize, height: Constants.minSize))
        moveToBottomCenter()
    }
    
    private func moveToBottomCenter() {
        guard let object = viewObject else { return }
        object.center = CGPoint(x: view.center.x, y: view.height() - Constants.safeVerticalMargin - object.height() / 2)
    }
    
    private func setupSegment() { }
    
    private func refreshRect() {
        guard let object = viewObject else { return }
        if object.width() >= object.height() {
            width += dif
            if width > view.safeWidth().max || width < view.safeWidth().min {
                width -= dif
                animateObject()
                return
            }
            height += dif
        } else {
            height += dif
            if height > view.safeHeight().max || height < view.safeHeight().min {
                height -= dif
                animateObject()
                return
            }
            width += dif
        }
        animateObject()
    }
    
    private func animateObject() {
        guard let object = viewObject else { return }
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            object.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
            self.moveToBottomCenter()
        }) { (_) in
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let originTouch = touches.first?.location(in: self.view) else { return }
        origin = originTouch.y
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let originTouch = touches.first?.location(in: self.view) else { return }
        dif = origin - originTouch.y
        refreshRect()
        origin = originTouch.y
    }

}
