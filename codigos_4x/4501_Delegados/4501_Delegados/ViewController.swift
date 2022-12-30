//
//  ViewController.swift
//  4501_Delegados
//
//  Created by Dragon on 30/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var precioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SeleccionarPlatilloSegue" {
            
            if let seleccionarPlatilloViewController = segue.destination as? SeleccionarPlatilloViewController {
                
                /// **PASO 5** - Conectar el delegado para reemplazar su funcionalidad opcional
                seleccionarPlatilloViewController.delegate = self
                
            }
            
        }
    }

    @IBAction func seleccionarPlatilloAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SeleccionarPlatilloSegue", sender: nil)
        
    }
    
}

/// **PASO 4** - Implementar el protocolo para establecer la funcionalidad a realizar
///             cuándo se mande a consumir el delegado
extension ViewController: PlatilloSeleccionado {
    
    func seleccionarPlatillo(nombre: String, precio: Double) {
        self.nombreLabel.text = nombre
        self.precioLabel.text = "$\(precio)"
    }
    
}

