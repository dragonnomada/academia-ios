//
//  ProfileDetailsPresenter.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import Foundation

class ProfileDetailsPresenter: NSObject {
    
    let router: ProfileRouter
    
    let interactor: ProfileInteractor
    
    var view: ProfileDetailsViewDelegate?
    
    init(router: ProfileRouter, interactor: ProfileInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    
    func createView() {
        self.view = ProfileDetailsViewController()
        self.view?.presenter = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.profileDetailsSelectedObserver), name: NSNotification.Name("Profile.service.profile"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshProfile), name: NSNotification.Name("Profile.service.update"), object: nil)
        
    }
    
    @objc func refreshProfile() {
        self.requestProfile()
    }
    
    @objc func profileDetailsSelectedObserver(notification: Notification) {
        if let profile = notification.object as? ProfileEntity {
            self.view?.profile(profileCreated: profile)
        }
    }
    
    func requestProfile() {
        self.interactor.requestProfile()
    }
    
    func removeView() {
        
        self.view = nil
    }
    
    func openProfileDetails() {
        self.router.openProfileDetails(presenter: self)
    }
    
    func closeProfileDetails() {
        self.router.closeProfileDetails(presenter: self)
    }
    
    func gotoProfileEdit() {
        NotificationCenter.default.post(name: NSNotification.Name("ProfileScene.goToProfileEdit"), object: self)
    }
    
}
