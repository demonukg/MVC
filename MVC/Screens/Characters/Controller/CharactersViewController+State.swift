//
//  CharactersViewController+State.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation

extension CharactersViewController {
    
    class State {
        
        enum Kind {
            
            case empty
            
            case error(Error)
            
            case initial
            
            case showingData([Character])
            
        }
        
        static func state(_ kind: Kind, vc: CharactersViewController) -> State {
            switch kind {
            case .empty:
                return EmptyState(vc: vc)
                
            case let .error(error):
                return ErrorState(error: error, vc: vc)
                
            case .initial:
                return InitialState(vc: vc)
                
            case let .showingData(characters):
                return ShowingDataState(characters: characters, vc: vc)
                
            }
        }
        
        weak var vc: CharactersViewController!
        
        init(vc: CharactersViewController) {
            self.vc = vc
        }
        
        func enter() {
            vc.contentView.tableView.reloadData()
        }
        
    }
    
    final class EmptyState: State {
        
    }
    
    final class ErrorState: State {
        
        let error: Error
        
        init(error: Error, vc: CharactersViewController) {
            self.error = error
            super.init(vc: vc)
        }
        
    }
    
    final class InitialState: State {
        
    }
    
    final class ShowingDataState: State {
        
        var characters: [Character]
        
        init(characters: [Character], vc: CharactersViewController) {
            self.characters = characters
            super.init(vc: vc)
        }
        
    }
    
}
