//
//  ViewController.swift
//  Lawan Kata
//
//  Created by Bisma S Wasesasegara on 06/02/20.
//  Copyright © 2020 Bisma S Wasesasegara. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

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
        object.center = CGPoint(x: view.center.x, y: view.height() - Constants.bottomPoint - object.height() / 2)
    }

}

