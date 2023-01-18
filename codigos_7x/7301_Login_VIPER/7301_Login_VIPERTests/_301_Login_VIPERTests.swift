//
//  _301_Login_VIPERTests.swift
//  7301_Login_VIPERTests
//
//  Created by Dragon on 18/01/23.
//

import XCTest
@testable import _301_Login_VIPER

class _301_Login_VIPERTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testFetchClousure() {
        
        print("Obteniendo usuarios aleatorios")
        
        RandomUserResponseEntity.fetch(results: 100) {
            
            randomUserResponse in
            
            print("Respuesta obtenida: \(randomUserResponse != nil ? "ÉXITO" : "FRACASO")")
            
            if let randomUserResponse = randomUserResponse {
                
                for randomUser in randomUserResponse.results {
                    
                    print(randomUser)
                    
                }
                
                randomUserResponse.toUserEntity {
                    
                    // users: [UserEntity]
                    users in
                    
                    for user in users {
                        
                        print(user)
                        
                    }
                    
                }
                
            } else {
                
                print("Sin respuesta")
                
            }
            
        }
        
        Thread.sleep(forTimeInterval: 10)
        
    }
    
    func testFetchAsync() async {
        
        let randomUserResponse = await RandomUserResponseEntity.fetch(results: 100)
        
        if let randomUserResponse = randomUserResponse {
            
            for randomUser in randomUserResponse.results {
                
                print(randomUser)
                
            }
            
            let users = await randomUserResponse.toUserEntity()
            
            for user in users {
                
                print(user)
                
            }

            
        }
        
    }
    
    func testLogin() async {
        
        let loginService = LoginService()
        
        let _ = loginService.userSignInSubject.sink { user in
            print("El usuario acaba de iniciar sesión: \(user)")
        }
        
        let _ = loginService.userSignOutSubject.sink { user in
            print("El usuario acaba de cerrar iniciar sesión: \(user)")
        }
        
        XCTAssertNil(loginService.userLogged)
        
        await loginService.signIn(username: "yellowzebra973", password: "mulder")
        
        XCTAssertNotNil(loginService.userLogged)
        
        if let userLogged = loginService.userLogged {
            
            XCTAssert(userLogged.email == "mitchell.watkins@example.com")
            XCTAssertNotNil(userLogged.picture)
            
            loginService.signOut()
            
            XCTAssertNil(loginService.userLogged)
            
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
