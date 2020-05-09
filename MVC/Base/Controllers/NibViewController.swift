//
//  NibViewController.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

class NibViewController<ContentView: UIView & NibViewInterface>: ViewController<ContentView> {

    override func loadContentView() -> ContentView {
        return ContentView.loadFromNib(owner: self, options: nil)
    }
}
