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
    private var origin: CGPoint = .zero
    private var width: CGFloat = 128
    private var height: CGFloat = 128
    private var corner: CGFloat = 4
    private var opacity: CGFloat = 1
    
    @IBOutlet weak var viewObject: UIView!
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    
    enum Dimension: Int {
        case size = 0
        case height
        case corner
        case opacity
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupObject()
        setupSegment()
    }
    
    private func setupObject() {
        guard let object = viewObject else { return }
        object.frame = CGRect(origin: .zero, size: CGSize(width: Constants.minSize, height: Constants.minSize))
        resetState()
    }
    
    private func setupSegment() {
        segmentSwitch.removeAllSegments()
        segmentSwitch.insertSegment(withTitle: "Besar", at: Dimension.size.rawValue, animated: false)
        segmentSwitch.insertSegment(withTitle: "Tinggi", at: Dimension.height.rawValue, animated: false)
        segmentSwitch.insertSegment(withTitle: "Tajam", at: Dimension.corner.rawValue, animated: false)
        segmentSwitch.insertSegment(withTitle: "Jelas", at: Dimension.opacity.rawValue, animated: false)
        segmentSwitch.selectedSegmentIndex = 0
    }
    
    private func moveToBottomCenter() {
        guard let object = viewObject else { return }
        object.center = CGPoint(x: view.center.x, y: view.height() - Constants.safeVerticalMargin - object.height() / 2)
    }
    
    private func refreshRect() {
        guard let segment = segmentSwitch else { return }
        switch segment.selectedSegmentIndex {
        case Dimension.size.rawValue:
            updateSize()
        case Dimension.height.rawValue:
            updateHeight()
        case Dimension.corner.rawValue:
            updateCorner()
        case Dimension.opacity.rawValue:
            updateOpacity()
        default:
            break
        }
    }
    
    private func updateSize() {
        let perspective = width > height ? height / width : width / height
        let widthDiff = dif * perspective
        let heightDiff = dif * perspective
        let oldWidth = width
        let oldHeight = height
        width += widthDiff
        height += heightDiff
        
        if width > view.safeWidth().max || width < view.safeWidth().min ||
           height > view.safeHeight().max || height < view.safeHeight().min {
               width -= widthDiff
               height -= heightDiff
        }
        
        let shortest = width > height ? height / 2 : width / 2
        let oldShortest = oldWidth > oldHeight ? oldHeight / 2 : oldWidth / 2
        if corner > shortest {
            corner = shortest
        } else {
            corner = shortest / oldShortest * corner
        }
        
        animateObject()
    }
    
    private func updateHeight() {
        height += dif
        if height > view.safeHeight().max || height < view.safeHeight().min {
            height -= dif
        }
        animateObject()
    }
    
    private func animateObject() {
        guard let object = viewObject else { return }
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            object.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
            object.layer.cornerRadius = self.corner
            object.alpha = self.opacity
            self.moveToBottomCenter()
        }) { (_) in
            
        }
    }
    
    private func updateCorner() {
        let max = width > height ? height / 2 : width / 2
        corner += dif
        if corner > max || corner < 0 {
            corner -= dif
        }
        animateObject()
    }
    
    private func resetState() {
        width = CGFloat(Constants.minSize)
        height = CGFloat(Constants.minSize)
        corner = 4
        opacity = 1
        moveToBottomCenter()
        animateObject()
    }
    
    private func updateOpacity() {
        opacity += dif * 0.1
        if opacity > 1 || opacity < 0 {
            opacity -= dif * 0.1
        }
        animateObject()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let originTouch = touches.first?.location(in: self.view) else { return }
        origin = originTouch
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let originTouch = touches.first?.location(in: self.view) else { return }
        dif = origin.y - originTouch.y + originTouch.x - origin.x
        refreshRect()
        origin = originTouch
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let originTouch = touches.first?.location(in: self.view) else { return }
        dif = origin.y - originTouch.y + originTouch.x - origin.x
        refreshRect()
        origin = originTouch
    }

    @IBAction func tapResetButton(_ sender: Any) {
        resetState()
    }
    
}
