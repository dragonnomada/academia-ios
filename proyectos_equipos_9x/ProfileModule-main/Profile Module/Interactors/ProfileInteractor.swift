//
//  ProfileInteractor.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import Foundation

class ProfileInteractor {
    
    lazy var service: ProfileService = {
        let service = ProfileService()
        return service
    }()
    
    
    func requestProfile() {
        self.service.requesProfile()
    }
    
    func updateProfile(byId id: Int32, name: String?, password: String?, img: Data?) {
        
        self.service.updateProfile(byId: id, name: name, password: password, img: img)
        
    }
    
    func createProfile(id: Int32, name: String, email: String, password: String, img:Data?) {
  
        self.service.createProfile(id: id, name: name, email: email, password: password, img: img)
    
    }
    
    func getProfile(byId id: Int32) {
        
        self.service.getProfile(byId: id)
    }
    
    func updateProfileSelected(name: String?, password: String?, image: Data?) {
        
     self.service.updateProfileSelected(name: name, password: password, image: image) 
    }
    
}
