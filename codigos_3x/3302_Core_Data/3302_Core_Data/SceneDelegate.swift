//
//  SceneDelegate.swift
//  3302_Core_Data
//
//  Created by User on 21/12/22.
//

import UIKit
import CoreData

///
/// # Introducción a Core Data
///
/// **Core Data** sirve para almacenar modelos predecibles mediante un contexto,
/// el cuál servirá para administrar nuestros objetos y poder almacenarlos o consultarlos.
///
/// Se dive en un *Contexto* (*NSManagedObiectContext*)
/// y un *Modelo* (*NSManagedObiectModel*).
///
/// Estos generarán objetos automáticos sobre nuestro código, los cuáles podremos
/// extender para mejorar su uso.
///
/// ## Configurar el Core Data
///
/// Lo primero es importar el framework de *CoreData* mediante el `import` en
/// el `AppDelegate`.
///
/// Lo siguiente será definir el `persistenContainer` dentro del `AppDelegate`.
///

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    /// **PASO 1** - Definir un `persistentContainer` a nivel `AppDelegate`
    private lazy var persistentContainer: NSPersistentContainer = {
        /// 1. Creamos un contenedor persistente
        let container = NSPersistentContainer(name: "ProductoModel")
        /// 2. Configuramos el contenedor persistente
        container.loadPersistentStores {
            (storeDescription, error) in
            if let error = error {
                fatalError("No se pudo configurar el contenedor persistente \(error)")
            }
        }
        /// 3. Devolvemos el contenedor persistente
        return container
    }() /// **NOTA:** Esta clausura debe auto-ejecutarse


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        /// **PASO 2** - Recuperar el RootViewController (el controlador principal)
        ///                y asociar al `persistentContainer`
        ///                para que tenga acceso a él
        
        /// Recuperarmos el `viewController` de la clase `ViewController`
        if let viewController = window?.rootViewController as? ViewController {
            /// Asociar el `persistentContainer` al `rootViewController`
            viewController.persistentContainer = persistentContainer
            /// **NOTA:** Como **PASO 3** debemos ir al `ViewController`
            ///             y crear la variable:
            /// ```swift
            /// var persistentContainer: NSPersistentContainer?
            /// ```
        }
        
        /// **ADVERTENCIA:** Si el `rootViewController` es un `NavigationViewController`,
        /// debemos recuperar el `ViewController` principal.
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

