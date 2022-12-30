//
//  AddViewController.swift
//  4502_Repaso_Combine
//
//  Created by User on 30/12/22.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func seleccionarEnchiladasAction(_ sender: Any) {
        PlatillosController.shared.seleccionarPlatillo(platillo: Platillo(nombre: "Enchiladas", descripcion: "Tortilla blanda con salsa verde o roja", precio: 25.99))
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func seleccionarChilaquilesAction(_ sender: Any) {
        PlatillosController.shared.seleccionarPlatillo(platillo: Platillo(nombre: "Chilaquiles", descripcion: "Tortilla sofrita con salsa roja o verde", precio: 34.93))
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func seleccionarPambazosAction(_ sender: Any) {
        PlatillosController.shared.seleccionarPlatillo(platillo: Platillo(nombre: "Pambazo", descripcion: "Pan tipo telera rellena de papa, chorizo, lechuga y queso blanco cubierta de chile adobado", precio: 44.5))
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
