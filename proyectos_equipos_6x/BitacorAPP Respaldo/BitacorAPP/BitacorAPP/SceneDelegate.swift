//
//  SceneDelegate.swift
//  BitacorAPP
//
//  Created by User on 10/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UINavigationControllerDelegate {

    var window: UIWindow?
    
    
    private lazy var model: BitacoraModel = {
        let model = BitacoraModel()
        // Cargamos las bitacoras y los estatus de las bitacoras desde que se crea.
        model.loadBitacoras()
        model.loadStatusOfBitacoras()
        
        /*let context = model.container.viewContext
        let requestBitacoras = BitacoraEntity.fetchRequest()
        if let bitacoras = try? context.fetch(requestBitacoras) {
            for bitacora in bitacoras {
                context.delete(bitacora)
            }
            do {
                try context.save()
            } catch {
                context.rollback()
            }
        }
        
        let requestStatus = BitacoraStatusEntity.fetchRequest()
        if let status = try? context.fetch(requestStatus) {
            for currentStatus in status {
                context.delete(currentStatus)
            }
            do {
                try context.save()
            } catch {
                context.rollback()
            }
        }*/
        
        
        return model
    }()
    
    private lazy var homeViewModel: BitacoraHomeViewModel = {
        let homeViewModel = BitacoraHomeViewModel(model: self.model)
        return homeViewModel
    }()
    
    private lazy var detailsViewModel: BitacoraDetailsViewModel = {
        let detailsViewModel = BitacoraDetailsViewModel(model: self.model)
        return detailsViewModel
    }()
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        //self.homeViewModel.view = nil
        self.detailsViewModel.view = nil
        self.detailsViewModel.unsubscribeToModel()
        
        if let viewController = viewController as? BitacoraHomeViewController {
            viewController.viewModel = self.homeViewModel
            self.homeViewModel.view = viewController
        }
        
        if let viewController = viewController as? BitacoraDetailsViewController {
            viewController.viewModel = self.detailsViewModel
            self.detailsViewModel.view = viewController
            self.detailsViewModel.subscribeToModel()
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
        // Crear la vista Root
        
        let navigationController = UINavigationController()
        
        navigationController.delegate = self
        
        navigationController.pushViewController(BitacoraHomeViewController(), animated: false)
        
        self.window?.rootViewController = navigationController
        
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

