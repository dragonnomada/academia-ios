//
//  SeleccionarPlatilloViewController.swift
//  4501_Delegados
//
//  Created by Dragon on 30/12/22.
//

import UIKit

// DELEGADOS NIVEL 2
// Los delegados decorados (formales) son protocolos con los cuales
// podemos abstraer la funcionalidad de devolver algo, sin tener que
// implementarlo. Otros componentes serán responsables de su implementación.
// En este modelo tendremos la opcionalidad.

/// **PASO 1** - Establecer el protocolo que tendrán que implementar otros componentes
protocol PlatilloSeleccionado {
    func seleccionarPlatillo(nombre: String, precio: Double)
}

class SeleccionarPlatilloViewController: UIViewController {
    
    // Yo espero a algún componente que implemente el protocolo `PlatilloSeleccionado`.
    // este puede ser una vista, un controlador, un modelo, etc.
    // El componente que implemente el protocolo `PlatilloSeleccionado`
    // será del tipo `PlatilloSeleccionado` y tendrá la funcionalidad
    // de `seleccionarPlatillo(nombre: String, precio: Double)`
    /// **PASO 2** - Peparar el delegado opcional esperado que implementará alguien más
    var delegate: PlatilloSeleccionado?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func seleccionarEnchiladasAction(_ sender: Any) {
        /// **PASO 3** - Consumir el delegado para que quién lo haya implementado
        ///             haga algo con los datos enviados
        self.delegate?.seleccionarPlatillo(nombre: "Enchiladas", precio: 25.99)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seleccionarChilaquilesAction(_ sender: Any) {
        /// **PASO 3** - Consumir el delegado para que quién lo haya implementado
        ///             haga algo con los datos enviados
        self.delegate?.seleccionarPlatillo(nombre: "Chilaquiles", precio: 34.93)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seleccionarPambazoAction(_ sender: Any) {
        /// **PASO 3** - Consumir el delegado para que quién lo haya implementado
        ///             haga algo con los datos enviados
        self.delegate?.seleccionarPlatillo(nombre: "Pambazo", precio: 44.56)
        self.navigationController?.popViewController(animated: true)
    }
    
}
