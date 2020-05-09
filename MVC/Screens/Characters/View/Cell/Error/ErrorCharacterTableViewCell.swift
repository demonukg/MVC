//
//  ErrorCharacterTableViewCell.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class ErrorCharacterTableViewCell: UITableViewCell {
    
    static let reuseId: String = "ErrorCharacterTableViewCell"
    
    @IBOutlet private weak var errorLabel: UILabel!
    
    var errorText: String! {
        didSet {
            errorLabel.text = errorText
        }
    }
}
