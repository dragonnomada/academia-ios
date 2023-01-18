//
//  UserEntity.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import Foundation

///
/// Las entidades retienen datos estructurados y pueden provenir o no del *CoreData*. Sirven para que los servicios proveean datos durante toda la aplicación.
///
/// Por ejemplo, si vienen de un API y se guardan localmente.
///
struct UserEntity {
    
    var fullname: String
    let email: String
    let username: String
    let password: String
    var picture: Data?
    
}
