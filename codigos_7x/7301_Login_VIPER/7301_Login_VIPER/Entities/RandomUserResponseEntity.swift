//
//  RandomUserResponseEntity.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import Foundation
import UIKit

struct RandomUserNameEntity: Codable {
    
    let first: String
    let last: String
    
}

struct RandomUserLongiEntity: Codable {
    
    let username: String
    let password: String
    
}

struct RandomUserPictureEntity: Codable {
    
    let large: String
    
}

struct RandomUserEntity: Codable {
    
    let name: RandomUserNameEntity
    let email: String
    let login: RandomUserLongiEntity
    let picture: RandomUserPictureEntity
    
}

struct RandomUserResponseEntity: Codable {
    
    let results: [RandomUserEntity]
    
    static func fetch(results: Int) async -> RandomUserResponseEntity? {
        
        var randomUserResponse: RandomUserResponseEntity?
        
        if let url = URL(string: "https://randomuser.me/api?results=\(results)&seed=1") {
            
            if let (data, _) = try? await URLSession.shared.data(for: URLRequest(url: url), delegate: nil) {
                
                if let result = try? JSONDecoder().decode(RandomUserResponseEntity.self, from: data) {
                    
                    randomUserResponse = result
                    
                }
                
            }
            
        }
        
        return randomUserResponse
        
    }
    
    static func fetch(results: Int, completion: @escaping (RandomUserResponseEntity?) -> Void) {
        
        if let url = URL(string: "https://randomuser.me/api?results=\(results)&seed=1") {
            
            let session = URLSession.shared.dataTask(with: url) {
                
                data, _, _ in
                
                if let data = data {
                    
                    if let result = try? JSONDecoder().decode(RandomUserResponseEntity.self, from: data) {
                        
                        completion(result)
                        return
                        
                    }
                    
                }
                
                completion(nil)
                
            }
            
            session.resume()
            
        } else {
            
            print("URL no válida")
            
        }
        
        
    }
    
    func toUserEntity() async -> [UserEntity] {
        
        var users: [UserEntity] = []
        
        for randomUser in self.results {
            
            let fullname = "\(randomUser.name.first) \(randomUser.name.last)"
            let email = randomUser.email
            let username = randomUser.login.username
            let password = randomUser.login.password
            
            var user = UserEntity(fullname: fullname, email: email, username: username, password: password, picture: nil)
            
            if let url = URL(string: randomUser.picture.large) {
                
                print("Descargando la imagen para el usuario \(fullname)")
                
                if let (data, _) = try? await URLSession.shared.data(for: URLRequest(url: url), delegate: nil) {
                    
                    user.picture = data
                }
            }
            
            users.append(user)
            
        }
        
        return users
        
    }
    
    func toUserEntity(completion: @escaping ([UserEntity]) -> Void) {
        
        var users: [UserEntity] = []
        
        func nextRandomUser(index: Int) {
            
            print("Procesando la imagen para el índice \(index)")
            
            guard index >= 0 && index < self.results.count else {
                
                print("Enviando usuarios ya con foto")
                completion(users)
                
                return
            }
            
            let randomUser = self.results[index]
            
            let fullname = "\(randomUser.name.first) \(randomUser.name.last)"
            let email = randomUser.email
            let username = randomUser.login.username
            let password = randomUser.login.password
            
            var user = UserEntity(fullname: fullname, email: email, username: username, password: password, picture: nil)
            
            if let url = URL(string: randomUser.picture.large) {
                
                let session = URLSession.shared.dataTask(with: url) {
                    data, _, _ in
                    
                    if let data = data {
                        
                        user.picture = data
                        
                    }
                    
                    users.append(user)
                    
                    nextRandomUser(index: index + 1)
                    
                }
                
                session.resume()
                
            }
            
        }
        
        nextRandomUser(index: 0)
        
    }
    
}
