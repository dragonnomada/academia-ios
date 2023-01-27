//
//  AddRouter.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import Foundation

extension HomeAddRouter {
    
    func openAdd(presenter: AddPresenter) {
        
        presenter.createView()
        
        if let viewController = presenter.view as? AddViewController {
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    func closeAdd(presenter: AddPresenter) {
        
        self.navigationController.popViewController(animated: true)
        
        presenter.removeView()
        
    }
    
}
