//
//  HomePresenter.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import Foundation


class HomePresenter {
    // Router
    weak var router: CaloriappRouter?
    
    // Interactor
    weak var interactor: UserInteractor?
    
    // View & ViewController
    weak var view: HomeView?
    
    lazy var viewController: HomeViewController = {
        let viewController = HomeViewController()
        viewController.presenter = self
        self.view = viewController
        return viewController
    }()
    
    // Connects & Disconnects
    
    func connectInteractor(interactor: UserInteractor) {
        
        self.interactor = interactor
   
    }
    
    func disconnectInteractor() {
        
        self.interactor = nil
        
    }
    
}


class HomeTabBarPresenter {
    // Router
    weak var router: CaloriappRouter?
    
    // Interactor
    weak var interactor: UserInteractor?
    
    // View & ViewController
    //weak var view: HomeView?
    
    lazy var tabBarController: HomeTabBarController = {
        
        let tabBarController = HomeTabBarController()
        tabBarController.presenter = self
        tabBarController.interactor = self.interactor
      //  self.view = viewController
        return tabBarController
    }()
    
    // Connects & Disconnects
    
    func connectInteractor(interactor: UserInteractor) {
        
        self.interactor = interactor
   
    }
    
    func disconnectInteractor() {
        
        self.interactor = nil
        
    }
    
}
