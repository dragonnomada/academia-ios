//
//  ViewController.swift
//  3203_Navigation_Controller
//
//  Created by User on 20/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    // Método activo:
    // Se ejecuta automáticamente cuándo el Segue está listo
    // con los datos recibidos y el destino asegurado
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "irPantallaDetalles":
            // Se está ejecutando el Segue para abrir la pantalla de detalles
            
            /// Un `segue` tiene un `.source` y un `.destination`
            /// el `.source` es el *View Controller* que mandó mando a llamar al segue (ej. `ViewController`)
            /// el `.destination` es el *View Controller* que ha sido llamado (ej. `PantallaDetallesViewController`)
            
            // Recuperamos el `segue.destination` como nuestro `PantallaDetallesViewController`
            
            guard let pantallaDetalles = segue.destination as? PantallaDetallesViewController else { return }
            
            /// El `sender` representa los datos que queremos transferir
            /// en este caso de tipo String
            
            guard let mensaje = sender as? String else { return }
            
            //pantallaDetalles.recibirDatos(mensaje: mensaje)
            //pantallaDetalles.mensaje = mensaje
//            pantallaDetalles.sendData {
//                putData in
//                putData(mensaje)
//            }
//            pantallaDetalles.putDataDelegate = {
//                (putData: (String) -> Void) in
//                putData(mensaje)
//            }
            pantallaDetalles.sendData(mensaje: mensaje)
        default:
            print("No sé qué hacer para otro segue")
        }
    }

    @IBAction func irPantalla2Action(_ sender: Any) {
        print("Abriendo Pantalla 2")
        self.performSegue(withIdentifier: "irPantallaDetalles", sender: "Hola mundo")
    }
    
}

