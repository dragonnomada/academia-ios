//
//  ProfileDetailsRouter.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import Foundation


extension ProfileRouter {
    
    func openProfileDetails(presenter: ProfileDetailsPresenter) {
        presenter.createView()
        
        if let viewController = presenter.view as? ProfileDetailsViewController {
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func closeProfileDetails(presenter: ProfileDetailsPresenter) {
        self.navigationController.popViewController(animated: true)
        presenter.removeView()
    }
    
    
}
