//
//  ViewControllerInterface.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerInterface: class {
    
    associatedtype ContentView
    
    var contentView: ContentView { get }
    
    func loadContentView() -> ContentView
}

extension ViewControllerInterface where Self: UIViewController {
    
    var contentView: ContentView {
        return view as! ContentView
    }
}

extension ViewControllerInterface where ContentView: NibViewInterface {
    
    func loadContentView() -> ContentView {
        return ContentView.loadFromNib(owner: self, options: nil)
    }
}
