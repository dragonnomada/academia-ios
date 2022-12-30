//
//  ViewController.swift
//  4501_Delegados
//
//  Created by User on 30/12/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nombreLabel: UILabel!
    
    
    @IBOutlet weak var precioLabel: UILabel!
    
  
    @IBAction func agregarPlatilloAction(_ sender: Any) {
        
        performSegue(withIdentifier: "SeleccionarPlatilloSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SeleccionarPlatilloSegue" {
            
            if let seleccionarPlatilloViewController = segue.destination as? SeleccionarPlatilloViewController {
                
                ///**PASO 3** - Reemplazar la variable/función (delegado) para hacer otra cosa
                ///cuando la variable/función sea llamada
                ///
                ///**Nota:** Tenemos dos tipos de reemplazo, mediangte una función formal o
                ///mediante una clausura
                //seleccionarPlatilloViewController.platilloSeleccionado = self.platilloSeleccionado()
                seleccionarPlatilloViewController.platilloSeleccionado = {
                    nombre, precio in
                    self.nombreLabel.text = nombre
                    self.precioLabel.text = "$\(precio)"
                }
            }
        }
    }
    
    func platilloSeleccionado(nombre: String, precio: Int) {
        self.nombreLabel.text = nombre
        self.precioLabel.text = "$\(precio)"
    }

}

