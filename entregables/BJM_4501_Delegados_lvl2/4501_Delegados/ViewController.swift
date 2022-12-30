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
            
            if let seleccionarPlatilloViewController = segue.destination as?
                SeleccionarPlatilloViewController {
                
                seleccionarPlatilloViewController.delegate = self
            }
        }
    }


}

extension ViewController: PlatilloSeleccionado {
    func seleccionarPlatillo(nombre: String, precio: Double) {
        self.nombreLabel.text = nombre
        self.precioLabel.text = "$\(precio)"
    }
}
