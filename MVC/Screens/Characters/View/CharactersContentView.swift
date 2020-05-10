//
//  CharactersContentView.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class CharactersContentView: UIView, NibViewInterface {
    
    static var nib: UINib = UINib(nibName: "CharactersContentView", bundle: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .done
        searchBar.placeholder = "Enter a name"
        searchBar.sizeToFit()
        return searchBar
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.sizeToFit()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = activityIndicator
        
        tableView.register(UINib(nibName: "InitialCharacterTableViewCell", bundle: nil),
                           forCellReuseIdentifier: InitialCharacterTableViewCell.reuseId)
        tableView.register(UINib(nibName: "ErrorCharacterTableViewCell", bundle: nil),
                           forCellReuseIdentifier: ErrorCharacterTableViewCell.reuseId)
        tableView.register(UINib(nibName: "EmptyCharacterTableViewCell", bundle: nil),
                           forCellReuseIdentifier: EmptyCharacterTableViewCell.reuseId)
        tableView.register(UINib(nibName: "ShowingDataCharacterTableViewCell", bundle: nil),
                           forCellReuseIdentifier: ShowingDataCharacterTableViewCell.reuseId)
        
    }
    
}
