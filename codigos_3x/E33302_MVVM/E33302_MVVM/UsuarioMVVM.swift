//
//  UsuarioMVVM.swift
//  E33302_MVVM
//
//  Created by MacBook Pro on 23/12/22.
//

import Foundation
import Combine

struct UsuarioData: Decodable {
    let id: Int
    let correo: String
    let contraseña: String
}

//VM
class LoginViewModel {
    static let shared = LoginViewModel()
    
    let iniciaSesionSubject = PassthroughSubject<(correo: String, contraseña: String), Never>()
    let usuarioAutenticadoSubject = PassthroughSubject<UsuarioData, Never>()
    
    var iniciaSesionSubscriber: AnyCancellable?
    
    init() {
        iniciaSesionSubscriber = self.iniciaSesionSubject.sink { (correo: String, contraseña: String) in
            print("Recibiendo \(correo) \(contraseña)")
            LoginModel.shared.iniciarSesion(correo: correo, contraseña: contraseña)
        }
    }
}
//M
class LoginModel {
    
    static let shared = LoginModel()
    
    var usuario: UsuarioData? = nil
    
    func iniciarSesion(correo: String, contraseña: String) {
        print("Iniciando sesión \(correo) \(contraseña)")
        if correo == "batman@gmail.com" && contraseña == "1234" {
            let usuario = UsuarioData(id: 1, correo: correo, contraseña: contraseña)
            self.usuario = usuario
            LoginViewModel.shared.usuarioAutenticadoSubject.send(usuario)
        }
    }
}
