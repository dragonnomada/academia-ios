//
//  UserInteractor.swift
//  MyDailyDiet
//
//  Created by MacBook on 23/01/23.
//

import Foundation
import Combine

class UserInteractor {
    
    // Servicio 
    private lazy var service: UserLoginService = {
        
        let service = UserLoginService()
        
        return service
        
    }()
    
    // Notificadores (replicadores)
    
    lazy var userSignInSubject: PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never> = {
        
        self.service.userSignInSubject
        
    }()
    
    lazy var userSignOutSubject: PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never> = {
        
        self.service.userSignOutSubject
        
    }()
    
    lazy var recurrentSignInSubject: PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never> = {
        
        self.service.recurrentSignInSubject
        
    }()
    
    
    lazy var userAuthCreatedSubject: PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never> = {
        
        self.service.userAuthCreatedSubject
        
    }()
    
    lazy var userInfoCreatedSubject: PassthroughSubject<(UserInfoEntity?, ServiceErrors?), Never> = {
        
        self.service.userInfoCreatedSubject
        
    }()
    
    lazy var userIsActiveSubject: PassthroughSubject<(UserAuthEntity?, ServiceErrors?), Never> = {
        
        self.service.userIsActiveSubject
        
    }()
    
    // Funciones
    
    func registerAuthUser(email: String, password: String) {
        
        self.service.registerAuthUser(email: email, password: password)
    }
    
    func updateUserInfo(name: String?, surname: String?, lastname: String?, birthDate: Date, height: Double, weight: Double, gender: String, phoneNumber: String) {
        
        self.service.updateUserInfo(name: name, surname: surname, lastname: lastname, birthDate: birthDate, height: height, weight: weight, gender: gender, phoneNumber: phoneNumber)
        
    }
    
    func LogInUser(email: String, password: String, active: Bool) {
        print("Interactor loginUser")
        service.LogInUser(email: email, password: password, active: active)
        
    }
    
    func LogOutUser() {
       
        self.service.LogOutUser()

    }
    
    func getLastUserActive() {
        
        self.service.getLastUserActive()
        
    }
    
    func autoSignIn(uid: String)  {
        
        self.service.autoSignIn(uid: uid)
        
    }
    
}
