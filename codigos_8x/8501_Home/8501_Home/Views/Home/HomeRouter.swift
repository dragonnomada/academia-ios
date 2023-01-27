//
//  HomeViewRouter.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import Foundation

extension HomeAddRouter {
    
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
