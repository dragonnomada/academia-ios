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
    var songInfoPresenter: SongInfoPresenter?
    var songPlayerPresenter: SongPlayerPresenter?
    
    func goToHome() {
        
        self.homePresenter = SongsHomePresenter()
        
        self.homePresenter?.start(router: self, interactor: self.interactor)
        
        if let viewController = self.homePresenter?.view as? HomeViewController {
            
            self.navigationController.pushViewController(viewController, animated: false)
            
        }
        
    }
    
    func goToSongInfo() {
        
        self.songInfoPresenter = SongInfoPresenter()
        
        self.songInfoPresenter?.start(router: self, interactor: self.interactor)
        
        if let viewController = self.songInfoPresenter?.view as? SongInfoViewController {
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    func goToPlayerFromInfo() {
        
        self.songInfoPresenter?.stop()
        
        self.navigationController.popViewController(animated: true)
        
        self.songInfoPresenter = nil
        
        self.goToSongPlayer()
        
    }
    
    func goToSongPlayer() {
        
        self.songPlayerPresenter = SongPlayerPresenter()
        
        self.songPlayerPresenter?.start(router: self, interactor: self.interactor)
        
        if let viewController = self.songPlayerPresenter?.view as? SongPlayerViewController {
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
}
