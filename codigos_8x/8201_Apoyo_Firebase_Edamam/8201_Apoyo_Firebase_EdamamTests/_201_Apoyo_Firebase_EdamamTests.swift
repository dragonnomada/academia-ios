//
//  _201_Apoyo_Firebase_EdamamTests.swift
//  8201_Apoyo_Firebase_EdamamTests
//
//  Created by MacBook  on 24/01/23.
//

import XCTest
import Combine
@testable import _201_Apoyo_Firebase_Edamam

final class _201_Apoyo_Firebase_EdamamTests: XCTestCase {

    var service: FirebaseService?
    
    var isValidEmailSubscriber: AnyCancellable?
    var isValidPasswordSubscriber: AnyCancellable?
    var createUserCredentialSubscriber: AnyCancellable?
    var createUserInfoSubscriber: AnyCancellable?
    var signInSubscriber: AnyCancellable?
    var autoSignInSubscriber: AnyCancellable?
    var signOutSubscriber: AnyCancellable?
    var userRememberedSubscriber: AnyCancellable?
    
    override func setUpWithError() throws {
        
        self.service = FirebaseService()
        
        guard let service = self.service else {
            print("No se pudo crear el servicio")
            return
        }
        
        self.isValidEmailSubscriber = service.isValidEmailSubject.sink {

                error in

                print("[isValidEmailSubscriber] Error: \(error)")

            } receiveValue: {

                userCredential in

                print("[isValidEmailSubscriber] \(userCredential)")

            }

            self.isValidPasswordSubscriber = service.isValidPasswordSubject.sink {

                error in

                print("[isValidPasswordSubscriber] Error: \(error)")

            } receiveValue: {

                userCredential in

                print("[isValidPasswordSubscriber] \(userCredential)")

            }

            self.createUserCredentialSubscriber = service.createUserCredentialSubject.sink {

                error in

                print("[createUserCredentialSubscriber] Error: \(error)")

            } receiveValue: {

                userCredential in

                print("[createUserCredentialSubscriber] \(userCredential)")

            }

            self.createUserInfoSubscriber = service.createUserInfoSubject.sink {

                error in

                print("[createUserInfoSubscriber] Error: \(error)")

            } receiveValue: {

                userCredential in

                print("[createUserInfoSubscriber] \(userCredential)")

            }

            self.signInSubscriber = service.signInSubject.sink {

                error in

                print("[signInSubscriber] Error: \(error)")

            } receiveValue: {

                userCredential in

                print("[signInSubscriber] \(userCredential)")

            }

            self.autoSignInSubscriber = service.autoSignInSubject.sink {

                error in

                print("[autoSignInSubscriber] Error: \(error)")

            } receiveValue: {

                userCredential in

                print("[autoSignInSubscriber] \(userCredential)")

            }

            self.signOutSubscriber = service.signOutSubject.sink {

                error in

                print("[signOutSubscriber] Error: \(error)")

            } receiveValue: {

                userCredential in

                print("[signOutSubscriber] \(userCredential)")

            }

            self.userRememberedSubscriber = service.userRememberedSubject.sink {

                error in

                print("[userRememberedSubscriber] Error: \(error)")

            } receiveValue: {
            
                userCredential in

                print("[userRememberedSubscriber] \(userCredential)")
            
            }
        
    }

    override func tearDownWithError() throws {
    }

    func testCreateUserCredential() {
        
        self.service?.createUserCredential(email: "pepe1010@gmail.com", password: "abc123")
        
        Thread.sleep(forTimeInterval: 60)
        
    }
    
    func testSignIn() {
        
        self.service?.signIn(withEmail: "pepe1010@gmail.com", password: "abc123")
        
        Thread.sleep(forTimeInterval: 60)
        
    }

}
