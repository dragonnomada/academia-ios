//
//  HomeTabBarController.swift
//  MyCaloriAPP
//
//  Created by User on 26/01/23.
//

import UIKit

class HomeTabBarController: UITabBarController {

    weak var presenter: HomeTabBarPresenter?
    
    // TODO: El Interactor
    weak var interactor: UserInteractor?
    
    // TODO: Los Presenters
    lazy var homePresenter: HomePresenter = {
        let presenter = HomePresenter()
        if let interactor = self.interactor {
            presenter.connectInteractor(interactor: interactor)
        }
        return presenter
    }()
    
    
    // TODO: Los ViewControllers
    
    lazy var homeViewController: HomeViewController = {
        
        let viewController = HomeViewController()
        viewController.title = "Inicio"
        self.homePresenter.view = viewController
        viewController.presenter = self.homePresenter
        return viewController
        
    }()
    
    lazy var myDietsViewController: MyDietsViewController = {
        let viewController = MyDietsViewController()
        viewController.title = "Mis Dietas"
        return viewController
    }()
    
    lazy var myProfileViewController: MyProfileViewController = {
        let viewController = MyProfileViewController()
        viewController.title = "Perfil"
        return viewController
    }()
    
    lazy var mySettingViewController: MySettingViewController = {
        let viewController = MySettingViewController()
        viewController.title = "Ajustes"
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.setViewControllers([homeViewController, myDietsViewController, myProfileViewController, mySettingViewController], animated: true)
        
        guard let items = self.tabBar.items else { return }
        
        items[0].image = UIImage(systemName: "house")
        items[1].image = UIImage(systemName: "fork.knife")
        items[2].image = UIImage(systemName: "person")
        items[3].image = UIImage(systemName: "slider.horizontal.3")
        
    }
    

}
