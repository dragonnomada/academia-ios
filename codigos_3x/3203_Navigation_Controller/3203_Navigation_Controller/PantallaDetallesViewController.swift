//
//  PantallaDetallesViewController.swift
//  3203_Navigation_Controller
//
//  Created by User on 20/12/22.
//

import UIKit

class PantallaDetallesViewController: UIViewController {
    
    @IBOutlet var myLabel: UILabel!
    
//    var mensaje: String = "Esperando datos..."
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("Se abrió la pantalla 2")
//
//        actualizarInterfaz()
//    }
//
//    // Método pasivo, cuándo lo llamamos la interfaz reacciona
//    func recibirDatos(mensaje: String) {
//        print("Recibí el mensaje: \(mensaje)")
//
//        ///
//        /// **Problema**: En  este momento no podemos usar `myLabel`
//        /// porque la vista todavía se está contruyendo
//        ///
//        /// **Solución**: Retener el mensaje dentro de está clase
//        ///
//
//        self.mensaje = mensaje
//
//        actualizarInterfaz()
//    }
//
//    func actualizarInterfaz() {
//        if let myLabel = myLabel {
//            /// En este punto ya se puede utiliza a `myLabel`
//            myLabel.text = mensaje
//        } else {
//            print("El label todavía no está listo")
//        }
//    }
    
    ///
    /// Un *delegado* es una función que recibe otra función.
    ///
    /// Es decir, el *delegate* recibe un *invoker*.
    ///
    /// Generalmente retenemos un delegado para poder actuar
    /// cuándo la función anidada sea mandada a llamar.
    ///
    /// A la función anidada la llamaremos el *invocador* (*invoker*).
    /// Esta es una función es la que procesará nuestras entradas de datos.
    ///
    /// A los delegados los podemos entender como
    /// **Eventos únicos** (**Single Events**)
    ///
    /// El delegado es una metafunción, una metaclausura o un portal de entrada.
    ///
    
    /// Creamos el *delegado* `putDataDelegate`
    /// el cuál espera un *invocador* de tipo `(String) -> Void`
    /// al *invocador* lo llamamos dentro de la clausura `putData`
    ///
    var putDataDelegate: ((String) -> Void) -> Void = {
        (putData: (String) -> Void) in
        /// `putData` representa el invocador
        /// y cada que es invocado manda a procesar al delegado
        /// es decir, recibe un `String` y no devuelve nada
        /// Este sería el invocar por defecto, que no hace nada
        /// (por defecto no hacemos la invocación a `putData: (String) -> Void`
        /// `putData` es una función del tipo invocador: `(String) -> Void`
        /// Ejemplo: invocar `putData("Hola mundo")`
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///
        /// **Procesar al delegado**:
        /// En este punto sabemos que la interfaz ya cargó
        /// y necesitamos controlar al delegado, para que
        /// cada que el delegado sea invocado
        /// nos devuelva el mensaje (`String`)
        /// y lo procesemos en una clausura de tipo `(String) -> Void`
        ///
        /// Establecemos qué hacer cuándo el invocador es llamado
        ///
        /// `putDataDelegate(<función: (String) -> Void>) -> Void`
        ///
        putDataDelegate {
            mensaje in
            /// Recibo el mensaje y lo actualizo en la interfaz
            myLabel.text = mensaje
        }
        
        // Llamar a un delegado, significa procesar al invocador
        putDataDelegate {
            mensaje in
            print("Mensaje recibido: \(mensaje)")
        }
    }
    
    ///
    /// El delegado por defecto no debería hacer nada o no debería
    /// invocar los datos dentro del delegado.
    ///
    /// Es decir, la clase tiene por defecto un delegado que hace nada,
    /// nunca manda a llamar al invocador.
    ///
    /// Por otro lado, en cualquier momento podemos mandar reemplazar
    /// al delegado, para que en algún otro lado del código, alguien pueda
    /// mandar a llamar al invocador (`putData`)
    ///
    ///
//    func sendData(putDataDelegate: @escaping ((String) -> Void) -> Void) {
//        /// **REEMPLAZA AL DELEGADO**
//        self.putDataDelegate = putDataDelegate
//    }
    
    func sendData(mensaje: String) {
        self.putDataDelegate = {
            putData in putData(mensaje)
        }
    }
    
    ///
    /// El `viewDidLoad()` tiene que mandar a llamar al *delegado*
    /// más reciente, porque en este momento ya tenemos al `label`
    ///
    /// El *delegado* tiene que reemplazado cuándo el *segue* esté listo.
    ///
    ///
    
}
