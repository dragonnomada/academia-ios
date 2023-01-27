//
//  RegisterUserPresenter.swift
//  MyDailyDiet
//
//  Created by MacBook on 25/01/23.
//

import Foundation
import Combine

class RegisterUserPresenter {
    
    private var router: MyDailyDietRouter?
    
    private var interactor: UserInteractor?
    
    var view: RegisterView?
    
    var userAuthCreatedSubscriber: AnyCancellable?
    var userInfoCreatedSubject: AnyCancellable?
    
    var userInfo: (name: String, surname: String, lastname: String, weight: Double)?
    
    //
    func start(router: MyDailyDietRouter, interactor: UserInteractor) {
        
        self.router = router
        self.interactor = interactor
        
        self.view = RegisterUserViewController()
        
        self.view?.presenter = self
        
        
        self.userInfoCreatedSubject = interactor.userInfoCreatedSubject.sink {
            
            userInfo, error in
            
            if let error = error {
                print("[userInfoCreatedSubject] Error: \(error)")
            }
            
            if let userInfo = userInfo {
                print("AVISAR A LA VISTA: \(userInfo)")
            }
            
        }
        
        self.userAuthCreatedSubscriber = interactor.userAuthCreatedSubject.sink {
            
            [weak self] userCredentials, error in
            
            if let error = error {
                print("[userAuthCreatedSubject] Error: \(error)")
            }
            
            if let _ = userCredentials {
                
                print("Se necesita actualizar la info")
                
                if let (name, surname, lastname, weight) = self?.userInfo {
                    
                    self?.interactor?.updateUserInfo(name: name, surname: surname, lastname: lastname, birthDate: Date.now, height: 0.0, weight: weight, gender: "MALE", phoneNumber: "123456789")
                    
                }
                
            }
            
        }
        
    }
    
    func registerUser(email: String, password: String, nombre: String) {
        
        self.userInfo = (name: nombre, surname: "Díaz", lastname: "Pérez", weight: 80.5)
        
        self.interactor?.registerAuthUser(email: email, password: password)
        
    }
    
    
}
