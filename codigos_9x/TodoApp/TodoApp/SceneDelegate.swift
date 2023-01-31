//
//  SceneDelegate.swift
//  TodoApp
//
//  Created by MacBook  on 31/01/23.
//

import UIKit
import TodoLibrary

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let todoScene = TodoScene()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        self.todoScene.createScene(window: self.window)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeSceneObserver), name: NSNotification.Name("SceneDelegate.changeScene"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeTodoAppObserver), name: NSNotification.Name("SceneDelegate.closeTodoApp"), object: nil)
    }
    
    @objc func changeSceneObserver(notification: Notification) {
        
        //if let (id, name, email, password) = notification.object as? (id: Int32, name: String, email: String, password: String) {
            //self.detailsScene.createScene(window: self.window, id, name, email, password)
        //}
        
        
    }
    
    @objc func closeTodoAppObserver(notification: Notification) {
        
        window?.rootViewController = DemoViewController(nibName: "DemoViewController", bundle: Bundle.main)
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

