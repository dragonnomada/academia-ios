//
//  ProfileService.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import Foundation
import Combine

enum ProfileServiceError: Error {
    case createProfile
    case updateProfile
    case getProfile
}

class ProfileService {
    
    private var profile: ProfileEntity?
    
    private var profiles: [ProfileEntity] = []
    
    private let profileStorage: ProfileStorage = ProfileStorage()
    
    private var profileCreated: ProfileEntity?
    
    private var profileUpdated: ProfileEntity?
    
    private var profileGeted: ProfileEntity?
    
    private var profileSelected: ProfileEntity?
    
    func requesProfile() {
        
        if let profile = self.profileStorage.getLastProfile() {
            self.profileSelected = profile
            NotificationCenter.default.post(name: NSNotification.Name("Profile.service.profile"), object: self.profileSelected)
        }
        
    
    }
    
    func createProfile(id: Int32, name: String, email: String, password: String, img:Data?) {
        
        if let profileCreated = self.profileStorage.createProfile(id: id, name: name, email: email , password: password, img: img) {
            
            self.profileCreated = profileCreated
            
            NotificationCenter.default.post(name: NSNotification.Name("Profile.service.create"), object: profileCreated)
            
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("Profile.service.createError"), object: ProfileServiceError.createProfile)
        }
        
    }
    
    func updateProfileSelected(name: String?, password: String?, image: Data?) {
        
        if let idProfileSelected = profileSelected?.idProfile, let profileUpdated = self.profileStorage.updateProfile(id: idProfileSelected, name: name, password: password, img: image) {
            self.profileUpdated = profileUpdated
            
            
            NotificationCenter.default.post(name: NSNotification.Name("Profile.service.update"), object: profileUpdated)
        
        
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("Profile.service.updateError"), object: ProfileServiceError.updateProfile)
            
        }
    }
    
    
    func updateProfile(byId id: Int32, name: String?, password: String?, img: Data?) { }
//    func updateProfile(byId id: Int32, name: String?, password: String?, img: Data?) {
//        if let profileUpdated = self.profileStorage.updateProfile(id: id, name: name, password: password, img: img) {
//
//            self.profileUpdated = profileUpdated
//
//            NotificationCenter.default.post(name: NSNotification.Name("Profile.service.update"), object: profileUpdated)
//
//        } else {
//            NotificationCenter.default.post(name: NSNotification.Name("Profile.service.updateError"), object: ProfileServiceError.updateProfile)
//        }
//    }
    
    func getProfile(byId id: Int32) {
        if let profileGeted = self.profileStorage.getProfile(byId: id) {
            
            self.profileGeted = profileGeted
            
            
            NotificationCenter.default.post(name: NSNotification.Name("Profile.service.get"), object: profileGeted)
            
            
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("Profile.service.getError"), object: ProfileServiceError.getProfile )
        }
    }
}
