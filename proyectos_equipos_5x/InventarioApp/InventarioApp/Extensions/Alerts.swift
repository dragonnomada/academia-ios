//
//  UIAlertController.swift
//  InventarioApp
//
//  Created by Dragon on 06/01/23.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func simpleAlert(title: String, message: String, label: String?) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: label, style: .default))
        
        return alert
        
    }
    
    static func simpleErrorAlert(message: String) -> UIAlertController {
        return UIAlertController.simpleAlert(title: "Error", message: message, label: "Aceptar")
    }
    
}
