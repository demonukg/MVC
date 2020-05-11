//
//  CharacterComicsViewController.swift
//  MVC
//
//  Created by Dmitry Y. on 5/11/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

final class CharacterComicsViewController: NibViewController<CharacterComicsContentView> {
    
    // MARK: - Initializers
    
    init(characterId: Int) {
        self.characterId = characterId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private properties
    
    private let characterId: Int
    
    private lazy var state = State.state(.loading, vc: self)
    
    
    // MARK: - View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        
        getComics(characterId: characterId) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.state = State.state(result.data.results.count == 0 ? .empty : .showingData(result.data.results), vc: self)
                self.state.enter()
                
            case .failure(let error):
                self.state = State.state(.error(error), vc: self)
                self.state.enter()
            }
        }
        
    }
    
}


//MARK: - UICollectionViewDataSource

extension CharacterComicsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let showingDataState = state as? State.ShowingDataState else { return 1 }
        
        return showingDataState.comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case let showingData as State.ShowingDataState:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowingDataComicsCollectionViewCell.reuseId, for: indexPath) as! ShowingDataComicsCollectionViewCell
            cell.comics = showingData.comics[indexPath.row]
            return cell
            
        case is State.EmptyState:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyComicsCollectionViewCell.reuseId, for: indexPath)
            return cell
            
        case let error as State.ErrorState:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorComicsCollectionViewCell.reuseId, for: indexPath) as! ErrorComicsCollectionViewCell
            cell.errorText = error.error.localizedDescription
            return cell
            
        case is State.LoadingState:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingComicsCollectionViewCell.reuseId, for: indexPath)
            return cell
            
        default:
            return UICollectionViewCell(frame: collectionView.frame)
        }
    }
    
}


//MARK: - UICollectionViewDelegate

extension CharacterComicsViewController: UICollectionViewDelegate {}


//MARK: - UICollectionViewDelegateFlowLayout

extension CharacterComicsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch state {
        case is State.ShowingDataState:
            let height = collectionView.bounds.height - 20.0
            let width = height / 1.5
            return CGSize(width: width, height: height)
            
        default:
            return collectionView.bounds.size
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch state {
        case is State.ShowingDataState:
            return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
            
        default:
            return .zero
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}

// MARK: - Requests

private extension CharacterComicsViewController {
    
    func getComics(characterId: Int, limit: Int? = 5, offset: Int? = nil, result: @escaping (Result<GetComicsResponse, Error>) -> Void) {
        let request = CharacterRouter.getCharacterComics(characterId: characterId, limit: limit, offset: offset)
        Networking.request(request) { (response: Result<GetComicsResponse, Error>) in
            result(response)
        }
    }
    
}


