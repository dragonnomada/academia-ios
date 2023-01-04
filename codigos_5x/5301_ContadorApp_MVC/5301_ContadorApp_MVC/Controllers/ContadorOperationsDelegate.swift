//
//  ContadorOperationsDelegate.swift
//  5301_ContadorApp_MVC
//
//  Created by Dragon on 04/01/23.
//

import Foundation
import UIKit

protocol ContadorOperationsDelegate {
    
    func contador(conteoIncremented valor: Int)
    
    func contador(conteoDecremented valor: Int)
    
    func contador(conteoReset valor: Int)
    
    func contador(conteoError error: String)
    
}

extension ContadorOperationsDelegate where Self: UIViewController {
    
    func contador(conteoError error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        
        self.present(alert, animated: true)
    }
    
}
