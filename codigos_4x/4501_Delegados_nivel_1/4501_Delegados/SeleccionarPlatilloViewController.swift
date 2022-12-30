//
//  SeleccionarPlatilloViewController.swift
//  4501_Delegados
//
//  Created by Dragon on 30/12/22.
//

import UIKit

// DELEGADOS NIVEL 1
// Los delegados crudos (o simples) usan directamente clausuras y variables/función
// para transmitir datos de un lugar a otro (de una vista a otra vista
// o de una vista a un controlador)

class SeleccionarPlatilloViewController: UIViewController {
    
    // Yo espero una función que reciba el nombre del platillo y su precio.
    // Pero, es posible que nadie me defina esa función.
    // Entonces yo mismo debería proponer una funcionalidad por defecto.
    // Esto significaría que cuándo yo selecciono un platillo, no hago nada
    // pero si alguién más me conecta una función con la misma firma
    // podrá hacer algo cuándo yo seleccione un platillo y mande a llamar
    // a esta función. Es decir, yo paso datos a `platilloSeleccionado`
    // y alguién más podría recibirlos fuera de aquí
    // (otra vista, un controlador, un modelo, etc).
    // func platilloSeleccionado(nombre: String, precio: Double)
    
    /// **PASO 1** - Definir una variable de tipo función con la firma esperada para
    ///             devolver los datos (transferencia de datos o salida)
    /// **Nota:** El proceso de sacar datos de una pantalla a través de una función
    ///             se conoce como inyección inversa
    var platilloSeleccionado: (String, Double) -> Void = { _, _ in }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func seleccionarEnchiladasAction(_ sender: Any) {
        /// **PASO 2** - Llamar la variable/función (delegado) para escapar los datos
        ///             hacía el último que definió la función (por defecto nosotros)
        self.platilloSeleccionado("Enchiladas", 25.99)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seleccionarChilaquilesAction(_ sender: Any) {
        /// **PASO 2** - Llamar a la variable/función (delegado) para escapar los datos
        ///             hacía el último que definió la función (por defecto nosotros)
        self.platilloSeleccionado("Chilaquiles", 34.93)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seleccionarPambazoAction(_ sender: Any) {
        /// **PASO 2** - Llamar a la variable/función (delegado) para escapar los datos
        ///             hacía el último que definió la función (por defecto nosotros)
        self.platilloSeleccionado("Pambazo", 44.5)
        self.navigationController?.popViewController(animated: true)
    }
    
}
