//
//  ViewController.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

class ViewController<ContentView: UIView>: UIViewController, ViewControllerInterface {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final override func loadView() {
        view = loadContentView()
    }
    
    func loadContentView() -> ContentView {
        fatalError("Should be overriden")
    }
}

