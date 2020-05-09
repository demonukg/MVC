//
//  NibViewInterface.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

protocol NibViewInterface: class {
    
    static var nib: UINib { get }
}

extension NibViewInterface {
    
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
    static func loadFromNib(owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self {
        return nib.instantiate(withOwner: owner, options: options)[0] as! Self
    }
}
