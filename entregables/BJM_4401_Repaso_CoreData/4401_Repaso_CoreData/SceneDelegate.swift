//
//  SceneDelegate.swift
//  4401_Repaso_CoreData
//
//  Created by User on 29/12/22.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    //Clousure auto-invokable () -> NSPersistentContainer
    
    /// **PASO 1** - Crear el contenedor
    let appPersistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AppModel")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("No se pudo recuperar el contenedor. Error: \(error)")
            }
        }
        
        return container
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        ///**PASO 3** - Conecta la instancia del ´appPersistentContainer´ hacia la vista
        ///
        ///**IMPORTANTE:** Hay que hacer las conversiones (reconversiones) necesarias para poder utilizar
        ///nuestra vista correctamente.
        if let viewController = self.window?.rootViewController as? ViewController {
            //Le explicamos a la vista que su contenedor es nuestro contenedor
            viewController.appPersistentContainer = self.appPersistentContainer
        }
        
        ///**IMPORTANTE:** Si la vista principal es ´rootViewController´) es un ´UINavigationController´,
        ///tendremos que recuperar el ´ViewController´desde el ´navigationController´, lo cual aumentará la complejidad
        if let navigationController = self.window?.rootViewController as? UINavigationController{
            if let viewController = navigationController.viewControllers.first as? ViewController {
                viewController.appPersistentContainer = self.appPersistentContainer
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

