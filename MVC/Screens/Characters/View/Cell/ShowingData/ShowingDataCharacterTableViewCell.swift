//
//  ShowingDataCharacterTableViewCell.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

final class ShowingDataCharacterTableViewCell: UITableViewCell {
    
    static let reuseId: String = "ShowingDataCharacterTableViewCell"
    
    @IBOutlet private weak var characterImageView: UIImageView!
    
    @IBOutlet private weak var characterNameLabel: UILabel!
    
    var character: Character! {
        didSet {
            characterImageView.image = nil
            if let url = character.thumbnail.url {
                characterImageView.af.setImage(withURL: url)
            }
            characterNameLabel.text = character.name
        }
    }
    
}
