//
//  LoginService.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import Foundation
import Combine

///
/// Los servicios son clases que actuan sobre las entidades y permiten definir transacciones sobre el sistema
///
/// Por ejemplo, para un sistema de repartición de productos, tendríamos las entidades del producto, el cliente, el repartidor, el pedido, etc. Y un servicio que realice todas las transacciones lógicas entre las entidades. Por ejemplo, determinar cuál es el cliente activo, cuál es el pedido y sus productos, quién es el repartidor y los procesos para entregar el paquete.
///
class LoginService {
    
    // STATE
    
    var userLogged: UserEntity?
    
    // Notificators (Subjects)
    
    let userSignInSubject = PassthroughSubject<UserEntity, Never>()
    let userSignOutSubject = PassthroughSubject<UserEntity, Never>()
    
    // Transactions
    
    func requestUserLogged() {
        
        if let userLogged = self.userLogged {
            userSignInSubject.send(userLogged)
        }
        
    }
    
    func signIn(username: String, password: String) async {
        
        print("Iniciando sesión para \(username)")
        
        if let randomUsersResponse = await RandomUserResponseEntity.fetch(results: 1_000) {
            
            randomUsersResponse.results.forEach { randomUser in
                print("\(randomUser.login.username) [\(randomUser.login.password)]")
            }
            
            if let randomUser = randomUsersResponse.results.filter({ randomUser in
                randomUser.login.username == username && randomUser.login.password == password
            }).first {
                
                let randomUsersResponse2 = RandomUserResponseEntity(results: [randomUser])
                
                if let user = await randomUsersResponse2.toUserEntity().first {
                    
                    self.userLogged = user
                    
                    self.userSignInSubject.send(user)
                    
                    print("Sesión iniciada")
                    
                } else {
                    
                    // TODO: Notificar que el usuario no pudo descargar su imagen
                    print("El usuario no pudo descargar su imagen")
                    
                }
                
            } else {
                
                // TODO: Notificar que el usuario y contraseña no existe
                print("El usuario y contraseña no existen")
                
            }
            
        } else {
            
            // TODO: Error al iniciar sesión (el api no responde)
            print("El api no responde")
            
        }
        
    }
    
    func signOut() {
        
        print("Cerrando sesión")
        
        if let userLogged = self.userLogged {
            
            self.userSignOutSubject.send(userLogged)
            self.userLogged = nil
            
            print("Sesión cerrada")
            
        } else {
            
            // TODO: Error al cerrar sesión (no se ha iniciado la sesión)
            
            print("No se pudo cerrar la sesión")
            
        }
        
    }
    
}
