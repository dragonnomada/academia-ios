//
//  File.swift
//  
//
//  Created by MacBook  on 31/01/23.
//

import Foundation
import UIKit

extension TodoRouter {
    
    public func showTodoHome(interactor: TodoInteractor, presenter: TodoHomePresenter) {
        
        presenter.createView(router: self, interactor: interactor)
        
        if let viewController = presenter.view as? UIViewController {
            
            self.showViewController(viewController: viewController)
            
        }
        
    }
    
}
