//
//  UserService.swift
//  MyDailyDiet
//
//  Created by MacBook on 23/01/23.
//  Updates:
//  Joel Brayan Navor Jimenez - Container created

import Foundation
import Combine
import CoreData
import FirebaseAuth
import UIKit


//Enumerable para el manejo de errores
enum ServiceErrors: Error {
    
    case invalidUser
    case getContext
    case createUser(Error)
    case saveContext(Error)
    case signIn(Error)
    case getUserByUid
    case getUserLogged
    case signOut(Error)
    case getActiveUserNotExist
}

class UserLoginService {
    
    //Creación del contenedor para cargar los datos persistentes
    lazy var containerUserInfo: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyDailyDiet")
        
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                fatalError("Error al cargar el contenedor del CoreData: \(error)")
                
            }
            
        }
        
        return container
        
    }()

    
    // STATES
    
    var userLogged: UserAuthEntity?
    
    // NOTIFICATORS
    
    let userSignInSubject = PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never>()
    let userSignOutSubject = PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never>()
    let recurrentSignInSubject = PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never>()
    let userAuthCreatedSubject = PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never>()
    let userInfoCreatedSubject = PassthroughSubject<(UserInfoEntity?, ServiceErrors?), Never>()
    let userIsActiveSubject = PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never>()
    
    // TRANSACTIONS
    
    func registerAuthUser(email: String, password: String) {
            
        Auth.auth().createUser(withEmail: email, password: password) {
            [weak self] (result, error) in
            
            if let error = error {
                
                self?.userAuthCreatedSubject.send((nil, .createUser(error)))
                
                return
                
            }
            
            if let result = result {
                
                guard let context = self?.containerUserInfo.viewContext else {
                    
                    self?.userAuthCreatedSubject.send((nil, .getContext))
                    return
                }
                
                let userAuthCredentials = UserAuthEntity(context: context)
                
                userAuthCredentials.email = email
                userAuthCredentials.password = password
                userAuthCredentials.uid = result.user.uid
                
                do {
                    
                    try context.save()
                    
                    self?.userLogged = userAuthCredentials
                    
                    self?.userAuthCreatedSubject.send((userAuthCredentials, nil))
                    
                } catch {
                    
                    context.rollback()
                    
                    self?.userAuthCreatedSubject.send((nil, .saveContext(error)))
                    
                }
                
            }
            
        }
        
    }
    
    func updateUserInfo(name: String?, surname: String?, lastname: String?, birthDate: Date, height: Double, weight: Double, gender: String, phoneNumber: String) {
        
        guard let userLogged = self.userLogged else {
            
            self.userInfoCreatedSubject.send((nil, .invalidUser))
            //TODO: manejor errores
            return
        }
        
        let context = self.containerUserInfo.viewContext
        
        let userInfo = UserInfoEntity(context: context)
        
        userInfo.name = name
        userInfo.surName = surname
        userInfo.lastName = lastname
        userInfo.gender = gender
        userInfo.phoneNumber = phoneNumber
        userInfo.birthDate = birthDate
        userInfo.weight = weight
        userInfo.height = height
        //Asignación de la información al usuario logeado con el correo y la contraseña
        userInfo.userAuth = userLogged
        
        do {
            
            try context.save()
            
            self.userInfoCreatedSubject.send((userInfo, nil))
            
        } catch {
            
            context.rollback()
            
            self.userInfoCreatedSubject.send((nil, .saveContext(error)))
            
        }
        
    }
    
    func LogInUser(email: String, password: String, active: Bool) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            
            [weak self] (result, error) in
            
            if let error = error {
                
                print("[UserLoginService] Error: \(error)")
                
                self?.userSignInSubject.send((nil, .signIn(error)))
                
            }
            
            if let result = result {
                
                guard let context = self?.containerUserInfo.viewContext else {
                    
                    self?.userSignInSubject.send((nil, .getContext))
                    
                    return
                }
                
                let uid = result.user.uid
                
                guard let userCredentials = try? context.fetch(UserAuthEntity.fetchRequest()).filter({ $0.uid == uid }).first else {
                    
                    print("[UserLoginService] No se encuentran las credenciales del usuario localmente (CoreData)")
                    
                    self?.userSignInSubject.send((nil, .getUserByUid))
                    
                    return
                }
                
                userCredentials.dateSigned = Date.now
                userCredentials.isActive = active
                
                do {
                    
                    try context.save()
                    
                    self?.userLogged = userCredentials
                    
                    print("[UserLoginService] Sesión iniciada: \(userCredentials)")
                    
                    self?.userSignInSubject.send((userCredentials, nil))
                    
                } catch {
                    
                    context.rollback()
                    
                    self?.userSignInSubject.send((nil, .saveContext(error)))
                    
                }
                
            }
            
        }
        
    }
    
    func LogOutUser() {
       
        guard let userLogged = self.userLogged else {
            
            self.userSignOutSubject.send((nil, .getUserLogged))
            
            return
        }
  
            do {
                
                try Auth.auth().signOut()
                
                userLogged.isActive = false
                
                let context = self.containerUserInfo.viewContext
                
                //self.userSignOutSubject.send((userLogged, nil))
                
                do {
                    
                    try context.save()
                    
                    self.userSignOutSubject.send((userLogged, nil))
                    
                    self.userLogged = nil
                    
                } catch {
                    
                    context.rollback()
                    
                    self.userSignOutSubject.send((nil, .saveContext(error)))
                    
                }
            } catch {
                
                self.userSignOutSubject.send((nil, .signOut(error)))
                
            }
            
        }

    
    
    func getLastUserActive() {
        
        let context = self.containerUserInfo.viewContext
        
        guard let userCredentials = try? context.fetch(UserAuthEntity.fetchRequest()).filter({ $0.isActive }).sorted(by: { $0.dateSigned?.timeIntervalSince1970 ?? 0 > $1.dateSigned?.timeIntervalSince1970 ?? 0 }).first else {
            
            self.userIsActiveSubject.send((nil, .getActiveUserNotExist))
            
            return
        }
        
        self.userIsActiveSubject.send((userCredentials, nil))
        
    }
    
    func autoSignIn(uid: String)  {
        
        guard let userCredentials = try? self.containerUserInfo.viewContext.fetch(UserAuthEntity.fetchRequest()).filter({ $0.uid == uid  }).first else {
            
            self.recurrentSignInSubject.send((nil, .invalidUser))
            
            return
            
        }
        
        guard userCredentials.isActive else {
            
            self.recurrentSignInSubject.send((nil, .invalidUser))
            return
        }
        
        guard let email = userCredentials.email else {
            
            self.recurrentSignInSubject.send((nil, .invalidUser))
            return
        }
        
        guard let password = userCredentials.password else {
            
            self.recurrentSignInSubject.send((nil, .invalidUser))
            return
        }
        
        self.LogInUser(email: email, password: password, active: true)
        
    }
    
    func requestUserLogged() {
        
        guard let userLogged = self.userLogged else {
            
            self.userSignInSubject.send((nil, .invalidUser))
            return
            
        }
        
        self.userSignInSubject.send((userLogged, nil))
        
    }
    
}
