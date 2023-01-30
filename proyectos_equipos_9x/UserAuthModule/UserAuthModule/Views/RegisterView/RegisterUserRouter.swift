//
//  RegisterUserRouter.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import Foundation

extension UserAuthRouter {
    
    func openRegister(presenter: RegisterUserPresenter) {
        
        presenter.createView()
        
        if let viewController = presenter.view as? RegisterUserViewController {
            
//            self.navigationController.present(viewController, animated: true)
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    func closeRegister(presenter: RegisterUserPresenter) {
        
        self.navigationController.popViewController(animated: true)
        
        presenter.removeView()
        
    }
    
}
