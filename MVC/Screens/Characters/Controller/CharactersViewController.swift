//
//  CharactersViewController.swift
//  MVC
//
//  Created by Dmitry Y. on 5/5/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import UIKit

final class CharactersViewController: NibViewController<CharactersContentView>  {
    
    // MARK: - Private properties
    
    private lazy var state: State = State.state(.initial, vc: self)
    
    private var searchTask: DispatchWorkItem?

    // MARK: - View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        contentView.searchBar.delegate = self
    }


}

//MARK: - UITableViewDataSource

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let showingDataState = state as? ShowingDataState else { return 1 }
        
        return showingDataState.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case is EmptyState:
            return tableView.dequeueReusableCell(withIdentifier: EmptyCharacterTableViewCell.reuseId, for: indexPath)
            
        case let errorState as ErrorState:
            let cell = tableView.dequeueReusableCell(withIdentifier: ErrorCharacterTableViewCell.reuseId, for: indexPath) as! ErrorCharacterTableViewCell
            cell.errorText = errorState.error.localizedDescription
            return cell
            
        case is InitialState:
            return tableView.dequeueReusableCell(withIdentifier: InitialCharacterTableViewCell.reuseId, for: indexPath)
            
        case let showingDataState as ShowingDataState:
            let cell = tableView.dequeueReusableCell(withIdentifier: ShowingDataCharacterTableViewCell.reuseId, for: indexPath) as! ShowingDataCharacterTableViewCell
            cell.character = showingDataState.characters[indexPath.row]
            return cell
        default:
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }
    
}

//MARK: - UITableViewDelegate

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let showingDataState = state as? ShowingDataState else { return }
        
        print(showingDataState.characters[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch state {
        case is ShowingDataState:
            return 70.0
            
        default:
            return tableView.bounds.height
        }
    }
    
}

//MARK: - UISearchBarDelegate

extension CharactersViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTask?.cancel()
        
        guard !searchText.isEmpty else { return }
        
        let task = DispatchWorkItem { [weak self] in
            self?.getCharacters(name: searchText, result: { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let result):
                    self.state = State.state(result.data.results.count == 0 ? .empty : .showingData(result.data.results), vc: self)
                    self.state.enter()
                    
                case .failure(let error):
                    self.state = State.state(.error(error), vc: self)
                    self.state.enter()
                }
            })
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: task)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let cancelButton : UIButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - Requests

private extension CharactersViewController {
    
    func getCharacters(name: String, limit: Int? = 20, offset: Int? = nil, result: @escaping (Result<GetCharactersResponse, Error>) -> Void) {
        let request = CharacterRouter.getCharacters(name: name, limit: limit, offset: offset)
        Networking.request(request) { (response: Result<GetCharactersResponse, Error>) in
            result(response)
        }
    }
    
}
