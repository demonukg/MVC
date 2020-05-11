//
//  CharacterDetailContentView.swift
//  MVC
//
//  Created by Dmitry Y. on 5/11/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class CharacterDetailContentView: UIView, NibViewInterface {
    
    static var nib: UINib = UINib(nibName: "CharacterDetailContentView", bundle: nil)
    
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var comicsContainerView: UIView!
    
    var character: Character! {
        didSet {
            if let url = character.thumbnail.url {
                characterImageView.af.setImage(withURL: url)
            }
        }
    }
    
    func addComicsView(_ childView: UIView) {
        comicsContainerView.addFullSubview(childView)
    }
    
}
