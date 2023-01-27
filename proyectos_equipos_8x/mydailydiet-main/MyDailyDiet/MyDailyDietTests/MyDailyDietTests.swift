//
//  MyDailyDietTests.swift
//  MyDailyDietTests
//
//  Created by MacBook on 23/01/23.
//

import XCTest
import FirebaseCore
import FirebaseAuth
import Combine
@testable import MyDailyDiet

final class MyDailyDietTests: XCTestCase {
    //Instancia del servicio a testear de tipo UserLoginService
    var service: UserLoginService?
    
    //Subscriptores a la escucha de notificaciones de los Sujetos(Subjects)
    var userSignInSubscriber: AnyCancellable?
    var userSignOutSubscriber: AnyCancellable?
    var recurrentSignInSubscriber: AnyCancellable?
    var userAuthCreatedSubscriber: AnyCancellable?
    var userInfoCreatedSubscriber: AnyCancellable?
    var userIsActiveSubscriber: AnyCancellable?
    
    //Seteo del servicio y de los subscriptores para la comprobación de errores
    override func setUpWithError() throws {
        
        self.service = UserLoginService()
        
        guard let service = self.service else {
            
            print("Error, no se pueo crear el servicio")
            
            return
            
        }
        
        }
    
    
    func testCreateUserCredentials() async {
        
        guard let service = self.service else {
            
            print("Error, no se pudo crear el servicio")
            
            return
            
        }
        
        self.userAuthCreatedSubscriber = service.userAuthCreatedSubject.sink {
            
            userCredentials, error in
            
            if let error = error {
                print("Error al crear el usuario: \(error)")
            }
            
            if let userCredentials = userCredentials {
                print("Credenciales creadas con los datos: [\(userCredentials)]")
            }
            
        }
        
        self.service?.registerAuthUser(email: "dummy04@gmail.com", password: "123456")
        
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
    }
    
    func testSignIn() async {
        
        guard let service = self.service else {
            
            print("Error, no se pudo crear el servicio")
            
            return
            
        }
        
        self.userSignInSubscriber = service.userSignInSubject.sink {
            
            userCredentials, error in
            
            if let error = error {
                print ("Error al subscribirse a userSignInSubject, Error: [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Iniciando sesión con las credenciales: [\(userCredentials)]")
            }
            
        }
        
        self.service?.LogInUser(email: "dummy02@gmail.com", password: "123456" , active: false)
        
        try? await Task.sleep(nanoseconds: 10_000_000_000)
    }
    
    func testLogOut() async {
        
        guard let service = self.service else {
            
            print("Error, no se pudo crear el servicio")
            
            return
            
        }
        
        self.userSignInSubscriber = service.userSignInSubject.sink {
            
            userCredentials, error in
            
            if let error = error {
                print ("Error al subscribirse a userSignInSubject, Error: [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Iniciando sesión con las credenciales: [\(userCredentials)]")
                self.service?.LogOutUser()
            }
            
        }
        
        self.userSignOutSubscriber = service.userSignOutSubject.sink {
            
            userCredentials,error in
            
            if let error = error {
                print ("Error al subscribirse a userSignOutSubject, Error: [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Cerrando sesión del usuario: [\(userCredentials)]")
            }
            
        }
        self.service?.LogInUser(email: "dummy02@gmail.com", password: "123456" , active: false)
        
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
    }
    
    func testUpdateInfoUser() async {
        
        guard let service = self.service else {
            
            print("Error, no se pudo crear el servicio")
            
            return
            
        }
        
        self.userInfoCreatedSubscriber = service.userInfoCreatedSubject.sink {
            
            userInfo, error in
            
            if let error = error {
                print ("Error al subscribirse a userInfoCreatedSubject, Error: [\(error)]")
            }
            
            if let userInfo = userInfo {
                print("Usuario actualizado: [\(userInfo)]")
            }
            
        }
        
        self.userSignInSubscriber = service.userSignInSubject.sink {
            
            userCredentials, error in
            
            if let error = error {
                print ("Error al subscribirse a userSignInSubject, Error: [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Sesión iniciada: [\(userCredentials)]")
                
                self.service?.updateUserInfo(name: "Joel", surname: "Navor", lastname: "Jimenez", birthDate: Date.now, height: 1.70, weight: 68.00, gender: "Male", phoneNumber: "2182938192")
            }
            
        }
        
        self.service?.LogInUser(email: "dummy02@gmail.com", password: "123456" , active: false)
        
        try? await Task.sleep(nanoseconds: 10_000_000_000)
       
        
    }
    
    func testGetLastUserActive() async {
        
        guard let service = self.service else {
            
            print("Error, no se pudo crear el servicio")
            
            return
            
        }
        
        self.userSignInSubscriber = service.userSignInSubject.sink {
            
            userCredentials, error in
            
            if let error = error {
                print ("Error al subscribirse a userSignInSubject, Error: [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Iniciando sesión con las credenciales: [\(userCredentials)]")
                
                self.service?.getLastUserActive()
            }
            
        }
        
        self.userIsActiveSubscriber = service.userIsActiveSubject.sink {
            
            userCredentials, error in
            
            if let error = error {
                print("Error userIsActiveSubject [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Ultimo usuario Activo: [\(userCredentials)]")
            }
        }
        
        self.service?.LogInUser(email: "dummy02@gmail.com", password: "123456" , active: true)
        
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
    }
    
    func testAutoSignIn() async {
        
        guard let service = self.service else {
            
            print("Error, no se pudo crear el servicio")
            
            return
            
        }
        
        self.userIsActiveSubscriber = service.userIsActiveSubject.sink {
            
            userCredentials,error in
            
            if let error = error {
                print("Error recurrentSignInSubject [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Usuario recuperado: [\(userCredentials)]")
                
                if let uid = userCredentials.uid {
                    self.service?.autoSignIn(uid: uid)
                }
                
            }
            
        }
        
        self.recurrentSignInSubscriber = service.recurrentSignInSubject.sink {
            
            userCredentials,error in
            
            if let error = error {
                print("Error recurrentSignInSubject [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Recibiendo al usuario que inicia sesión de manera recurrente: [\(userCredentials)]")
            }
            
        }
        
        self.userSignInSubscriber = service.userSignInSubject.sink {
            
            userCredentials,error in
            
            if let error = error {
                print("Error userSignInSubject [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Usuario iniciado: [\(userCredentials)]")
            }
            
        }
        
        self.service?.getLastUserActive()
    
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
    }
    
    func testRequestUserLogged() async {
        
        guard let service = self.service else {
            
            print("Error, no se pudo crear el servicio")
            
            return
            
        }
        
        self.userSignInSubscriber = service.userSignInSubject.sink {
            
            userCredentials, error in
            
            if let error = error {
                print ("Error al subscribirse a userSignInSubject, Error: [\(error)]")
            }
            
            if let userCredentials = userCredentials {
                print("Usuario Logeado: [\(userCredentials)]")
                
                
            }
            
        }
        
        self.service?.LogInUser(email: "dummy02@gmail.com", password: "123456" , active: true)
        
        
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
