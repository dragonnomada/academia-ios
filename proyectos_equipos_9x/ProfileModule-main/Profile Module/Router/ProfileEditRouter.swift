//
//  ProfileEditRouter.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import Foundation


extension ProfileRouter {
 
    func openProfileEdit(presenter: ProfileEditPresenter) {
        presenter.createView()
        
        if let viewController = presenter.view as? ProfileEditViewController {
            self.navigationController.present(viewController, animated: true)
            
            //self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func closeProfileEdit(presenter: ProfileEditPresenter) {
        if let viewController = presenter.view as? ProfileEditViewController {
            viewController.dismiss(animated: true)
        }
        //self.navigationController.popViewController(animated: true)
        presenter.removeView()
    }
    
    
}
