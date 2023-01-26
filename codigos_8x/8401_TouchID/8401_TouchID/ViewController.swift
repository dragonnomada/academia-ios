//
//  ViewController.swift
//  8401_TouchID
//
//  Created by MacBook  on 26/01/23.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func autenticarAction() {
        
        let context = LAContext()
        
        let reason = "Se necesita la autenticación por rostro o huella."
        
        var authError: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                
                success, error in
                
                if let error = error {
                    
                    print("Error al autenticar: \(error)")
                    
                }
                
                if success {
                    
                    print("Usuario autenticado exitósamente")
                    
                }
                
            }
            
        } else {
            
            print("Error al evaluar la política: \(authError?.description ?? "SIN DESCRIPCIÓN")")
            
        }
        
    }

}

