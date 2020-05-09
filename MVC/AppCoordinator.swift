//
//  AppCoordinator.swift
//  MVC
//
//  Created by Dmitry Y. on 5/9/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorInterface {
    
    var window: UIWindow { get }
    
    init(window: UIWindow)
    
    func start()
    
}

final class AppCoordinator: AppCoordinatorInterface {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = UINavigationController(rootViewController: CharactersViewController())
    }
    
    
}
