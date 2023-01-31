//
//  UserServiceTests.swift
//  MyCaloriAPPTests
//
//  Created by User on 26/01/23.
//

import XCTest
import Combine
@testable import MyCaloriAPP

final class UserServiceTests: XCTestCase {
        
    let userService = UserService()
    
    var loadCoreDataUsersSubscriber: AnyCancellable?
    var verifyEmailAlredySignedUpSubscriber: AnyCancellable?
    var signUpEmailAndPasswordSubscriber: AnyCancellable?
    var signUpUserProfileSubscriber: AnyCancellable?
    var loginWithEmailAndPasswordSubscriber: AnyCancellable?
    var logoutActiveUserSubscriber: AnyCancellable?

    func testLoadCoreDataUsers() {
        
        let testExpectation = expectation(description: "Se inicializa el contenedor persistente y se carga el contexto del UserEntity correctamente")
        
        self.loadCoreDataUsersSubscriber = self.userService.loadCoreDataUsersSubject.sink( receiveValue: {
            
            response in
            
            if let error = response.error {
                
                print(error.rawValue)
            }
            
            if let users = response.users {
                
                print(users.count)
                testExpectation.fulfill()
            }
        })
        
        self.userService.loadCoreDataUsers()
        
        waitForExpectations(timeout: 10)
    }
    
    func testverifyEmailAlredySignedUp() {
                
        let testExpectation = expectation(description: "Se verifica si el correo existe en FireBase")
                
        self.verifyEmailAlredySignedUpSubscriber = self.userService.verifyEmailAlredySignedUpSubject.sink( receiveValue: {
            
            response in
            
            if let error = response.error {
                
                print(error.rawValue)
            }
            
            if let email = response.email {
                
                print(email)
                testExpectation.fulfill()
            }
        })
                
        self.userService.verifyEmailAlredySignedUp("error")
        self.userService.verifyEmailAlredySignedUp("error@error.com")
        self.userService.verifyEmailAlredySignedUp("test@test.com")

        waitForExpectations(timeout: 10)
    }
    
    func testSignUp() {
        
        let testExpectation1 = expectation(description: "Se da de alta correo electrónico y contraseña en FireBase")
        let testExpectation2 = expectation(description: "Se da de alta perfil de usuario en CoreData")
        
        self.signUpEmailAndPasswordSubscriber = self.userService.signUpEmailAndPasswordSubject.sink( receiveValue: {
            
            response in
            
            if let error = response.error {
                
                print(error.rawValue)
            }
            
            if let user = response.user {
                
                testExpectation1.fulfill()
                print(user)
                self.userService.signUpUserProfile(userId: user.uid, name: "Test Name", lastName: "Test LastName", userEmail: user.email, userPassword: user.password, userName: "Test User", gender: true, height: 175.0, weight: 80.0, birthDate: Date.now, phoneNumber: "55-55-55-55-55")
            }
        })
        
        self.signUpUserProfileSubscriber = self.userService.signUpUserProfileSubject.sink(receiveValue: {
            
            response in
            
            if let error = response.error {
                
                print(error.rawValue)
            }
            
            if let user = response.user {
                
                print(user)
                testExpectation2.fulfill()
            }
        })
        
        self.userService.loadCoreDataUsers()
        self.userService.verifyEmailAlredySignedUp("test0@test.com") //last tested test0
        self.userService.signUpEmailAndPassword(email: "test0@test.com", password: "123456")
        
        waitForExpectations(timeout: 10)
    }
    
    func testloginWithEmailAndPassword() {
        
        let testExpectation = expectation(description: "Se loguea un usuario por medio de su correo electrónico y contraseña en FireBase, y se recupera su perfil del CoreData")
        
        self.loginWithEmailAndPasswordSubscriber = self.userService.loginWithEmailAndPasswordSubject.sink( receiveValue: {
            
            response in
            
            if let error = response.error {
                
                print(error.rawValue)
            }
            
            if let activeUser = response.activeUser {
                
                print(activeUser)
                testExpectation.fulfill()
            }
        })
        
        self.userService.loadCoreDataUsers()
        self.userService.verifyEmailAlredySignedUp("test@test.com")
        self.userService.loginWithEmailAndPassword(email: "test@test.com", password: "123456")
        
        waitForExpectations(timeout: 10)
    }
    
    func testlogoutActiveUser() {
        
        let testExpectation1 = expectation(description: "Se loguea un usuario por medio de su correo electrónico y contraseña en FireBase, y se recupera su perfil del CoreData")
        
        let testExpectation2 = expectation(description: "Cierra sesión en FireBase el usuario activo")
        
        self.loginWithEmailAndPasswordSubscriber = self.userService.loginWithEmailAndPasswordSubject.sink( receiveValue: {
            
            [weak self] response in
            
            if let error = response.error {
                
                print(error.rawValue)
            }
            
            if let activeUser = response.activeUser {
                
                print(activeUser)
                testExpectation1.fulfill()
                self?.userService.logoutActiveUser()
            }
        })
        
        self.logoutActiveUserSubscriber = self.userService.logoutActiveUserSubject.sink( receiveValue: {
            
            response in
            
            if let error = response.error {
                
                print(error.rawValue)
            }
            
            if let success = response.success {
                
                print(success)
                testExpectation2.fulfill()
            }
        })
        
        self.userService.loadCoreDataUsers()
        self.userService.verifyEmailAlredySignedUp("test@test.com")
        self.userService.loginWithEmailAndPassword(email: "test@test.com", password: "123456")
        
        waitForExpectations(timeout: 10)
    }
    
}
