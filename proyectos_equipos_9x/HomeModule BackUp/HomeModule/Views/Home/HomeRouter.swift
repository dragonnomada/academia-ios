//
//  HomeRouter.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import Foundation

extension HomeModuleRouter {
    
    func openHome(presenter: HomePresenter) {
        
        presenter.createView()
        
        if let viewController = presenter.view as? HomeViewController {
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    func closeHome(presenter: HomePresenter) {
        
        self.navigationController.popViewController(animated: true)
        
        presenter.removeView()
        
    }
    
}
