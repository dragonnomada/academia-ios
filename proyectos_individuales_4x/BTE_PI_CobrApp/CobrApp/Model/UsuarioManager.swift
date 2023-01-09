//
//  UsuarioManager.swift
//  CobrApp
//
//  Created by MacBook Pro on 28/12/22.
//

import UIKit
import Combine

struct UsuarioManager {
    
    static let shared = UsuarioManager()
    
    /// **PASO 1** - Crear un sujeto capaz de enviar booleanos a sus suscriptores
    let informaLoginSubject = PassthroughSubject<Bool, Never>()
    
}


/*
 /// **PASO 3** - Crear un suscriptor al que le importe lo que envia el sujeto
 var informaLoginSubscriber: AnyCancellable?
 
 // Do any additional setup after loading the view.
 
 /// **PASO 4** - Enlazar el suscriptor al sujeto mediante `.sink { recivedValue in ...code... }`
 
 
//        informaLoginSubscriber = UsuarioManager.shared.informaLoginSubject.sink(receiveValue: {
//
//            sesionValida in
//
//            if sesionValida {
//                self.performSegue(withIdentifier: "Login-QR-Segue", sender: nil)
//            } else {
//                DispatchQueue.main.async {
             let alert = UIAlertController(title: "Sesión no válida", message: "No se pudo iniciar sesión", preferredStyle: .alert)

             alert.addAction(UIAlertAction(title: "Ok", style: .default))

             self.present(alert, animated: true)
//                }
//            }
     
//    })
 
 */


//        let compraValida = false
//
//        print(compraValida)
//        if compraValida {
//            performSegue(withIdentifier: "ValidoQR-ValidoCobro-Segue", sender: nil)
//        } else {
//            performSegue(withIdentifier: "ValidoQR-InvalidoCobro-Segue", sender: nil)
//        }


/// **Paso 2** - Enviamos un booleano a través del sujeto a sus suscriptores
//informaLoginSubject.send(false)

/// **Paso 2** - Enviamos un booleano a través del sujeto a sus suscriptores
//informaLoginSubject.send(true)v
