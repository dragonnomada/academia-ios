//
//  SongsRouter.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import Foundation
import UIKit

class SongsRouter {
    
    lazy var navigationController: UINavigationController = {
        
        let navigationController = UINavigationController()
        
        return navigationController
        
    }()
    
    lazy var interactor: SongInteractor = {
        
        let interactor = SongInteractor()
        
        return interactor
        
    }()
    
    var homePresenter: SongsHomePresenter?
    
    func goToHome() {
        
        self.homePresenter = SongsHomePresenter()
        
        self.homePresenter?.start(router: self, interactor: self.interactor)
        
        if let viewController = self.homePresenter?.view as? HomeViewController {
            
            self.navigationController.pushViewController(viewController, animated: false)
            
        }
        
    }
    
}
