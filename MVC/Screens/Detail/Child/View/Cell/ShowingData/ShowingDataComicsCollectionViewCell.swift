//
//  ShowingDataComicsCollectionViewCell.swift
//  MVC
//
//  Created by Dmitry Y. on 5/11/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class ShowingDataComicsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId: String = "ShowingDataComicsCollectionViewCell"
    
    var comics: Comics! {
        didSet {
            activityIndicator.startAnimating()
            comicsImageView.image = nil
            if let url = comics.thumbnail.url {
                comicsImageView.af.setImage(withURL: url) { _ in
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    @IBOutlet private weak var comicsImageView: UIImageView!
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        comicsImageView.addFullSubview(activityIndicator)
    }
    
    
}
