//
//  SceneDelegate.swift
//  3401_Repaso_CoreData
//
//  Created by User on 22/12/22.
//

import UIKit
import CoreData

/// Una **auto-clausura** es una clausura
/// que se manda ejecutar y el resultado es devuelto.
/// La ventaja es que la *auto-clausura* permite
/// ejecutar más cosas antes de devolver el resultado.
let a: Int = {
    print("Hola mundo")
    return 123
}()

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

//    lazy var appModel: NSPersistentContainer = NSPersistentContainer(name: "AppModel")
    
    lazy var appModel: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "AppModel")
        
        container.loadPersistentStores(completionHandler: {
            (_, error) in
            if let error = error {
                fatalError("No se puedieron cargar los datos del contenedor. Error: \(error)")
            }
        })
        
        return container
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        /// Recuperar la instancia del `ViewController` principal
        /// directamente del `window?.rootViewController`
        if let viewController = window?.rootViewController as? ViewController {
            viewController.appModel = appModel
        }
        
        if let navigationController = window?.rootViewController as? UINavigationController {
            if let viewController = navigationController.viewControllers.first as? ViewController {
                viewController.appModel = appModel
            }
        }
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

