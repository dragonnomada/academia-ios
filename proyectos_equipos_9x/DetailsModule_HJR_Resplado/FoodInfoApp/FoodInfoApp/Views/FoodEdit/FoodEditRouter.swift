//
//  FoodEditRouter.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//
// OK

import Foundation

extension DetailsEditRouter {
    
    func openDetails(presenter: FoodEditPresenter) {
        
        presenter.createView()
        
        if let viewController = presenter.view as? FoodEditViewController {
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    func closeDetails(presenter: FoodEditPresenter) {
        
        self.navigationController.popViewController(animated: true)
        
        presenter.removeView()
        
    }
    
}
