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
                
                /// **PASO 3** - Reemplazar la variable/función (delegado) para hacer otra cosa
                ///             cuándo la variable/función sea llamada
                /// **Nota:** Tenemos dos tipos de reemplazo, mediante una función formal
                ///             o mediante una clausura
                //seleccionarPlatilloViewController.platilloSeleccionado = self.platilloSeleccionado
                seleccionarPlatilloViewController.platilloSeleccionado = {
                    nombre, precio in
                    self.nombreLabel.text = nombre
                    self.precioLabel.text = "$\(precio)"
                }
                
            }
            
        }
    }
    
    func platilloSeleccionado(nombre: String, precio: Double) {
        self.nombreLabel.text = nombre
        self.precioLabel.text = "$\(precio)"
    }

    @IBAction func seleccionarPlatilloAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SeleccionarPlatilloSegue", sender: nil)
        
    }
    
}

