//
//  LoginUserRouter.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import Foundation

extension UserAuthRouter {
    
    func openLogin(presenter: LoginUserPresenter) {
        
        presenter.createView()
        
        if let viewController = presenter.view as? LoginUserViewController {
            
            self.navigationController.pushViewController(viewController, animated: true)
            
        }
    }
    
    func closeLogin(presenter: LoginUserPresenter) {
            
        self.navigationController.popViewController(animated: true)
            
        presenter.removeView()
            
        }
        
    }

