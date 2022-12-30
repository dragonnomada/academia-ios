//
//  SeleccionarPlatilloViewController.swift
//  4501_Delegados
//
//  Created by User on 30/12/22.
//

import UIKit

//Los delegados crudos (o simples) usan directamente clausuras y variables/función
//para transmitir funcionalidad de un lugar a otro (de una vista a otra vista
// o de nua vista a un controlador)

class SeleccionarPlatilloViewController: UIViewController {
    
    // Yo espero una función que reciba el nombre del platillo y su precio.
    // Pero, es posible que nadie me defina esa funcion.
    //Entonces significaría que cuando yo selecciono un platillo, no hago nada
    //pero si alguine mas me conecta una funcion con la misma firma
    //podra hacer algo cuando yo seleccione un platillo y mande a llamar
    //a esta funcion. Es decir, yo paso datos a ´platilloSeleccionado´
    //y alguien mas podrá recibirlos fuera de aqui
    //(otra vista, un controlador, un modelo, etc.)
    
    /// **PASO 1** - Definir una variable de tipo función con la firma esperada para devolver
    ///             los datos (transferencia de datos o salida)
    ///**NOTA:** El proceso de sacar datos de una pantalla a través de una función se conoce
    ///como inyección inversa.
    var platilloSeleccionado: (String, Double) -> Void = { _, _ in }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func seleccionarEnchiladasAction(_ sender: Any) {
        /// **PASO 2** - Llamar a la variable/función (delegado) para escapar los datos
        ///hacia el último que definió la función (por defecto nosotros)
        self.platilloSeleccionado("Enchiladas", 25.99)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func seleccionarChilaquilesAction(_ sender: Any) {
        self.platilloSeleccionado("Chilaquiles", 34.93)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func seleccionarPambazoAction(_ sender: Any) {
        self.platilloSeleccionado("Pambazo", 44.5)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    

}
