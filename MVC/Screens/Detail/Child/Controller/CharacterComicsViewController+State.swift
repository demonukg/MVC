//
//  CharacterComicsViewController+State.swift
//  MVC
//
//  Created by Dmitry Y. on 5/11/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

extension CharacterComicsViewController {
    
    class State {
        
        enum Kind {
            
            case empty
            
            case error(Error)
            
            case loading
            
            case showingData([Comics])
            
        }
        
        weak var vc: CharacterComicsViewController!
        
        static func state(_ kind: Kind, vc: CharacterComicsViewController) -> State {
            
            switch kind {
            case .empty:
                return EmptyState(vc: vc)
                
            case .error(let error):
                return ErrorState(error: error, vc: vc)
                
            case .loading:
                return LoadingState(vc: vc)
                
            case .showingData(let comics):
                return ShowingDataState(comics: comics , vc: vc)
            }
            
        }
        
        init(vc: CharacterComicsViewController) {
            self.vc = vc
        }
        
        func enter() {
            // what to do with header
            vc.contentView.collectionView.reloadData()
        }
        
        final class EmptyState: State {
            
        }
        
        final class ErrorState: State {
            
            let error: Error
            
            init(error: Error, vc: CharacterComicsViewController) {
                self.error = error
                super.init(vc: vc)
            }
            
        }
        
        final class LoadingState: State {
            
        }
        
        final class ShowingDataState: State {
            
            var comics: [Comics]
            
            init(comics: [Comics], vc: CharacterComicsViewController) {
                self.comics = comics
                super.init(vc: vc)
            }
            
            func addNewComics(_ comics: [Comics]) {
                guard !comics.isEmpty else { return }
                
                let numberOfExistingItems = vc.contentView.collectionView.numberOfItems(inSection: 0)
                let totalNumberOfItems = (numberOfExistingItems - 1) + comics.count
                
                let indexPaths = ((numberOfExistingItems - 1) ... (totalNumberOfItems - 1)).map({ IndexPath(row: $0, section: 0) })
                
                vc.contentView.collectionView.performUsingPresentationValues {
                    self.comics.append(contentsOf: comics)
                    self.vc.contentView.collectionView.insertItems(at: indexPaths)
                }
            }
        }
    }
}
