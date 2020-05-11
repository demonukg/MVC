//
//  CharacterDetailViewController.swift
//  MVC
//
//  Created by Dmitry Y. on 5/11/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class CharacterDetailViewController: NibViewController<CharacterDetailContentView> {
    
    // MARK: - Initializers
    
    init(character: Character) {
        self.character = character
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private properties
    
    private let character: Character
    
    private var comicsController: CharacterComicsViewController! {
        didSet {
            addChild(comicsController)
            contentView.addComicsView(comicsController.view)
            comicsController.didMove(toParent: self)
        }
    }
    
    
    // MARK: - View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = character.name
        contentView.character = character
        
        comicsController = CharacterComicsViewController(characterId: character.id)
    }
    
}
