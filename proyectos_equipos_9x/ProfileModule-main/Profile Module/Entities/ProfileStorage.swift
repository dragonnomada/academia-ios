//
//  ProfileStorage.swift
//  Profile Module
//
//  Created by MacBook Pro on 27/01/23.
//

import Foundation
import CoreData

class ProfileStorage {
    
    private lazy var profileContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ProfileModel")
        
        container.loadPersistentStores { _, error in
            
            if let error = error {
                fatalError("[ProfileStorage] El contenedor persistente no pudo ser creado")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext { self.profileContainer.viewContext }
    
    private func save() -> Bool {
        
        do {
            try self.context.save()
            return true
        } catch {
            self.context.rollback()
            return false
        }
        
    }
    
    
    func createProfile(id: Int32, name: String, email: String, password: String, img: Data?) -> ProfileEntity? {
        
        if let profileExists = try? self.context.fetch(ProfileEntity.fetchRequest()).filter({ $0.idProfile == id }).first {
            return profileExists
        }
        
        let profile = ProfileEntity(context: context)
        
        profile.idProfile = id
        profile.nameProfile = name
        profile.emailProfile = email
        profile.passwordProfile = password
        
        if let img = img { profile.imageProfile = img }
        
        return self.save() ? profile : nil
        
    }
    // FUNCION PARA PRUEBAS UNITARIAS - NO REQUERIDA EN EL PROYECTO
    func getProfiles() -> [ProfileEntity] {
        
        if let profiles = try? self.context.fetch(ProfileEntity.fetchRequest()) {
            
            return profiles
            
        } else {
            return []
        }
        
    }
    
    func getLastProfile() -> ProfileEntity? {
        
        if let profile = try? self.context.fetch(ProfileEntity.fetchRequest()) {
            
            return profile.last
            
        } else {
            return nil
        }
        
    }
    
    func getProfile(byId id: Int32) -> ProfileEntity? {
        if let profile = try? self.context.fetch(ProfileEntity.fetchRequest()).filter({ $0.idProfile == id }).first {
            return profile
        }
        return nil
    }
    
    
    func updateProfile(id: Int32, name: String?, password: String?, img:Data?) -> ProfileEntity? {
        
        if let profile = try? self.context.fetch(ProfileEntity.fetchRequest()).filter({ $0.idProfile == id }).first {
            
            if let name = name { profile.nameProfile = name }
            if let password = password { profile.passwordProfile = password }
            if let img = img { profile.imageProfile = img }
            
            let _ = self.save()
            return profile
            
        }
        return nil
    }
        
}
    

