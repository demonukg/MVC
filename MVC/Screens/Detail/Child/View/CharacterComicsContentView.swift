//
//  CharacterComicsContentView.swift
//  MVC
//
//  Created by Dmitry Y. on 5/11/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class CharacterComicsContentView: UIView, NibViewInterface {
    
    static var nib: UINib = UINib(nibName: "CharacterComicsContentView", bundle: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "ShowingDataComicsCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: ShowingDataComicsCollectionViewCell.reuseId)
        collectionView.register(UINib(nibName: "LoadingComicsCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: LoadingComicsCollectionViewCell.reuseId)
        collectionView.register(UINib(nibName: "ErrorComicsCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: ErrorComicsCollectionViewCell.reuseId)
        collectionView.register(UINib(nibName: "EmptyComicsCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: EmptyComicsCollectionViewCell.reuseId)
    }
    
}
