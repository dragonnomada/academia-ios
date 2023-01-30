//
//  UserAuthStorage.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//
// 27/01/2023
// updated by:
// Joel Brayan Navor Jimenez

import Foundation
import CoreData // Importación de coredata para el uso de datos persistentes

class UserAuthStorage {
    
    private lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ProfileModule")
        
        container.loadPersistentStores {
            
            _, error in
                
                if let error = error {
                    
                    fatalError("[ProfileModule/Container] UserEntity loadPersistentStore ")
                    
                }
            
        }
        
        return container
        
    }()
    
    private var context: NSManagedObjectContext { self.container.viewContext }
    
    private func save() -> Bool {
        
        do {
            
            try self.context.save()
            return true
            
        } catch {
            
            self.context.rollback()
            return false
            
        }
        
    }
    
    func createUser(email: String, name: String, password: String, image: Data?, dateRegister: Date) -> UserAuthInfoEntity? {
        
        let newUser = UserAuthInfoEntity(context: self.context)
        
        newUser.name = name
        newUser.password = password
        newUser.email = email
        newUser.image = image
        newUser.dateRegister = Date.now
        
        return self.save() ? newUser : nil
    }
    
    func getUsers() -> [UserAuthInfoEntity] {

        if let users = try? self.context.fetch(UserAuthInfoEntity.fetchRequest()) {

            return users

        } else {

            fatalError("[ProfileModule/Container] UserEntity GetUser")
            
            

        }

    }
    
}

