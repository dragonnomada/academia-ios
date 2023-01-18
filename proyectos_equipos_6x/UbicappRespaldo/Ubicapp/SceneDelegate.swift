//
//  SceneDelegate.swift
//  Ubicapp
//
//  Created by MacBook on 10/01/23.
//

import UIKit

//   Proyecto: Ubicapp
//
// Autores:
// Joel Brayan Navor Jimenez
// Jonathan
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 12 de enero del 2023 por jonothan Amador
// Modificaciones:
// Modificado por: Jonathan Amador el 13/01/2023
//


class SceneDelegate: UIResponder, UIWindowSceneDelegate, UINavigationControllerDelegate {

    var window: UIWindow?

    lazy var ubicappModel: UbicappModel = {
        let modelo = UbicappModel()
        modelo.loadUbicaciones()
        return modelo
    }()
    
    lazy var qrViewModel: QRViewModel = {
        let qrViewModel  = QRViewModel(model: self.ubicappModel)
        return qrViewModel
    }()

    lazy var mapaViewModel: MapaViewModel = {
        let mapaViewModel = MapaViewModel(model: self.ubicappModel)
        return mapaViewModel
    }()
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if let viewController = viewController as? QRViewController {
            
            self.qrViewModel.view = viewController
            viewController.qrViewModel = self.qrViewModel
            
        }
        
        if let viewController = viewController as? MapaViewController {
    
            // Conexion de modelo con vista-modelo
            self.mapaViewModel.view = viewController
            viewController.mapaViewModel = self.mapaViewModel
            
        }
        
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
        let navigationController = UINavigationController()
        
        navigationController.pushViewController(MapaViewController(), animated: false)
        
        navigationController.delegate = self
        
        //
        window?.rootViewController = navigationController
        
        
        
        
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

