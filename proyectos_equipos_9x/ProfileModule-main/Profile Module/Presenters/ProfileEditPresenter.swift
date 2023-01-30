//
//  ProfileEditPresenter.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import Foundation

class ProfileEditPresenter: NSObject {
    
    let router: ProfileRouter
    
    let interactor: ProfileInteractor
    
    var view: ProfileEditViewDelegate?
    
    init(router: ProfileRouter, interactor: ProfileInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func requestProfile() {
        self.interactor.requestProfile()
    }
    
    func createView() {
        
        self.view = ProfileEditViewController()
        self.view?.presenter = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.editProfileSelectedObserver), name: NSNotification.Name("Profile.service.profile"), object: nil)
    }
    
    @objc func editProfileSelectedObserver(notification:  Notification) {
        if let profile = notification.object as? ProfileEntity {
            self.view?.profile(profileSelected: profile)
        }
    }
    
    @objc func updateProfileSelectedObserver(notificacion: Notification) {
        if let profile = notificacion.object as? ProfileEntity {
            self.view?.profile(profileSelected: profile)
        }
    }
    func removeView() {
        
        self.view = nil
    }
    
    func openProfileEdit() {
        self.router.openProfileEdit(presenter: self)
    }
    
    func closeProfileEdit() {
        self.router.closeProfileEdit(presenter: self)
    }
    
    func updateProfile(name: String?, password: String?, img: Data?) {
        
        self.interactor.updateProfileSelected(name: name, password: password, image: img)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateProfileSelectedObserver), name: NSNotification.Name("Profile.service.update"), object: nil)
    }
    
   
    func gotoDetails() {
        NotificationCenter.default.post(name: NSNotification.Name("ProfileScene.backToDetails"), object: self)
    }
    
}
