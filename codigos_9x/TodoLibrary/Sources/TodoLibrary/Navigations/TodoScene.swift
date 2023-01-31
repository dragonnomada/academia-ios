//
//  File.swift
//  
//
//  Created by MacBook  on 31/01/23.
//

import Foundation
import UIKit

public class TodoScene: NSObject {
    
    let todoRouter = TodoRouter()
    
    let todoInteractor = TodoInteractor()
    
    let todoHomePresenter = TodoHomePresenter()
    
    public func createScene(window: UIWindow?) {
        
        window?.rootViewController = self.todoRouter.navigationController
        
        window?.makeKeyAndVisible()
        
        self.openTodoHome()
        
        // SUBSCRIPTIONS TO NAVIGATE OTHERS
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.openTodoAdd), name: NSNotification.Name("TodoScene.openTodoAdd"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeAll), name: NSNotification.Name("TodoScene.closeAll"), object: nil)
        
    }
    
    @objc func openTodoAdd(notification: Notification) {
        
        print("Navengando hacia TodoAdd")
        
        self.openTodoHome()
        
        //self.todoRouter.showTodoAdd(presenter: self.todoAddPresenter)
        
    }
    
    @objc func closeAll(notification: Notification) {
        
        print("Cerrando todo")
        
        //self.closeTodoHome()
        
        NotificationCenter.default.post(name: NSNotification.Name("SceneDelegate.closeTodoApp"), object: nil)
        
    }
    
    func openTodoHome() {
        
        self.todoRouter.showTodoHome(interactor: self.todoInteractor, presenter: self.todoHomePresenter)
        
    }
    
}
