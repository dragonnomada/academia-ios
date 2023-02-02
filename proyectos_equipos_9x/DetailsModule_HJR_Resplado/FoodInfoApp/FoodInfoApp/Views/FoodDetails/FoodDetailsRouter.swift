//
//  FoodDetailsRouter.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import Foundation
import UIKit

extension DetailsEditRouter {
    
    func openDetails(presenter: FoodDetailsPresenter) {
        
        presenter.createView()
        
        if let viewController = presenter.view as? FoodDetailsViewController {
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    func closeDetails(presenter: FoodDetailsPresenter) {
        
        self.navigationController.popViewController(animated: true)
        
        presenter.removeView()
        
    }
    
}
