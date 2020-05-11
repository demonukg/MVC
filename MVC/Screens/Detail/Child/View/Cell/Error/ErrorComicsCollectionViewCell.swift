//
//  ErrorComicsCollectionViewCell.swift
//  MVC
//
//  Created by Dmitry Y. on 5/11/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class ErrorComicsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId: String = "ErrorComicsCollectionViewCell"
    
    @IBOutlet private weak var errorLabel: UILabel!
    
    var errorText: String! {
        didSet {
            errorLabel.text = errorText
        }
    }
    
}
