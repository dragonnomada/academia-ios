//
//  ProfileScene.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import UIKit

class ProfileSecene: NSObject {
    
    let interactor = ProfileInteractor()
    let router = ProfileRouter()
    
    lazy var detailsPresenter: ProfileDetailsPresenter = {
        
        let presenter = ProfileDetailsPresenter(router: self.router, interactor: self.interactor)
        
        return presenter
    }()
    
    lazy var editPresenter: ProfileEditPresenter = {
        let presenter = ProfileEditPresenter(router: self.router, interactor: self.interactor)
        return presenter
    }()
    
    func createScene(window: UIWindow?) {
        
        window?.rootViewController = self.router.navigationController
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToProfileEdit), name: NSNotification.Name("ProfileScene.goToProfileEdit"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.openProfileDetails), name: NSNotification.Name("Profile.service.create"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeProfileEdit), name: NSNotification.Name("Profile.service.update"), object: nil)
    }
    
    func installProfile(id: Int32, name: String, email: String, password: String, img:Data?) {
        
        self.interactor.createProfile(id: id, name: name, email: email, password: password, img: img)
        
    }
    
    @objc func closeProfileEdit() {
        self.editPresenter.closeProfileEdit()
    }
    
    @objc func openProfileDetails() {
        self.detailsPresenter.openProfileDetails()
    }
    
   @objc func goToProfileEdit() {
       self.openProfileEdit()
    }
    
    func openProfileEdit() {
        self.editPresenter.openProfileEdit()
    }
}
