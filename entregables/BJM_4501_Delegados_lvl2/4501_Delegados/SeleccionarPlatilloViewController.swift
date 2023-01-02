//
//  SeleccionarPlatilloViewController.swift
//  4501_Delegados
//
//  Created by User on 30/12/22.
//

import UIKit

//DELEGADOS NIVEL 2
//Los delegados decorados (formales) son protocolos con los cuales
//podemos abstraer la funcionalidad de devolver algo, sin tener que
//implementarlo. Otros componentes serán responsables de su implementación.
//En este modelo tendremos la opcionalidad.

//Definición de PROTOCOLO: colección/conjunto de funcionalidades

protocol PlatilloSeleccionado {
    func seleccionarPlatillo(nombre: String, precio: Double)
}

class SeleccionarPlatilloViewController: UIViewController {
    
    ///Yo espero a algún componente que implemente el protocolo ´PlatilloSeleccionado´
    ///este puede ser una vista, un controlador, un modelo, etc.
    ///El componente que implemente el protocolo ´PlatilloSeleccionado´
    ///será del tipo ´PlatilloSeleccionado´y tendrá la funcionalidad de
    ///´seleccionarPlatillo(nombre: String, precio: Double)
    
    var delegate: PlatilloSeleccionado?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func seleccionarEnchiladasAction(_ sender: Any) {
        self.delegate?.seleccionarPlatillo(nombre: "Enchiladas", precio: 25.99)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func seleccionarChilaquilesAction(_ sender: Any) {
        self.delegate?.seleccionarPlatillo(nombre: "Chilaquiles", precio: 67.90)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func seleccionarPambazoAction(_ sender: Any) {
        self.delegate?.seleccionarPlatillo(nombre: "Pambazos", precio: 30.0)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    

}
