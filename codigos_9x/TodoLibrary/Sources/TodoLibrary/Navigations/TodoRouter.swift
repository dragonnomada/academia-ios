//
//  File.swift
//  
//
//  Created by MacBook  on 31/01/23.
//

import Foundation
import UIKit

public class TodoRouter {
    
    public lazy var navigationController: UINavigationController = {
        
        let navigationController = UINavigationController()
        
        navigationController.navigationBar.barTintColor = .systemPink
        
        return navigationController
        
    }()
    
    private var currentViewController: UIViewController?
    private var lastViewController: UIViewController?
    
    func showViewController(viewController: UIViewController) {
        
        self.lastViewController = self.currentViewController
        self.currentViewController = viewController
        
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func hideViewController() {
        
        self.navigationController.popViewController(animated: true)
        
        self.currentViewController = self.lastViewController
        self.lastViewController = nil
        
    }
    
    func showViewControllerAsModal(viewController: UIViewController) {
        
        self.lastViewController = self.currentViewController
        self.currentViewController = viewController
        
        self.navigationController.present(viewController, animated: true)
        
    }
    
    func hideViewControllerAsModal() {
        
        self.currentViewController?.dismiss(animated: true) {
            
            [unowned self] in
            
            self.currentViewController = self.lastViewController
            self.lastViewController = nil
            
        }
        
    }
    
}
