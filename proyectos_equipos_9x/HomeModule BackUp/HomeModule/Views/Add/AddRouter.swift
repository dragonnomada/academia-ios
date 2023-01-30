//
//  AddRouter.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import Foundation

extension HomeModuleRouter {
    
    func openAdd(presenter: AddPresenter) {
        
        presenter.createView()
        
        if let viewController = presenter.view as? AddViewController {
            
            self.navigationController.present(viewController, animated: true)
        }
        
    }
    
    func closeAdd(presenter: AddPresenter) {
        
        self.navigationController.dismiss(animated: true)
        presenter.removeView()
    }
    
}
