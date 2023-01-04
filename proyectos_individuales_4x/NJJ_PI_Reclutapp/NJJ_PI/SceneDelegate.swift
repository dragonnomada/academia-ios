//
//  SceneDelegate.swift
//  NJJ_PI
//  Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
//  Trabajo Creado el 27/12/22.
//  Proyecto Individual ReclutaApp
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData // Impooración de core data para el uso de datos persistentes

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    //Creación de la variable prospectosModel para asignarle los datos del contenedor recibidos del modelo con su key ("Prospectos")
    lazy var prospectosModel: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "Prospectos")
           //container cargara los datos y de no lograrlo nos arrojara un error.
           container.loadPersistentStores(completionHandler: {
               (_, error) in
               if let error = error {
                   fatalError("No se puedieron cargar los datos del contenedor. Error: \(error)")
               }
           })
           //Si los carga correctamente los retornara.
           return container
       }()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        //vamos a instanciar una constante ya sea del tipo viewController para pantallas creadas con view controller o navigationController para pantallas creadas con NavigationController.
        
        if let viewController = window?.rootViewController as? ViewController {
                  //le asignamos el modelo de datos persistentes a nuestro viewController
                  viewController.prospectoPersistentContainer = prospectosModel
              }
              //Tratamos de instancias una constante del tipo navigation controller de tipo rootViewController para despues asignarselo a nuestro viewController
              if let navigationController = window?.rootViewController as? UINavigationController {
                  // Tratamos de crear una constante viewController para pasarle nuestro navigationController y proveerle de los datos persistentes del modelo.
                  if let viewController = navigationController.viewControllers.first as? ViewController {
                      viewController.prospectoPersistentContainer = prospectosModel
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

