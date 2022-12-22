//
//  ViewController.swift
//  3404_Combine_Framework
//
//  Created by User on 22/12/22.
//

import UIKit
import Combine

///
/// El *Framework Combine* nos permite controlar objetos
/// de forma reactiva a través de *Publicadores* (`Publisher`),
/// *Sujetos* (`Subject`) y *Suscriptores* (`Subscriptor`).
///
/// Estos tienen el objetivo de generar una instancia capaz de reportar
/// valores que estén siendo enviados (a través del *publicador*) y
/// siendo recibidos (a través del *suscriptor*).
///
/// De todo el *framework* lo más útil será entender la parte del
/// *Sujeto* y la *Suscripción*.
///
/// Existe un *sujeto* genérico llamado `PassthroughSubject` el cuál
/// retiene un último valor pasado y permite suscribirse a dichos valores
/// para poder observar cuál es el objeto enviado o pasado.
///
/// Cada que el *sujeto* envía un valor nuevo, los suscriptores pueden
/// recibirlo y procesarlo, incluso aplicarles un mapeo previo o alguna lógica.
///

class ViewController: UIViewController {
    
    @IBOutlet weak var frutaLabel: UILabel!
    
    @IBOutlet weak var frutaTextField: UITextField!
    
    /// **Paso 1** - Diseñar un *Sujeto* de tipo `PassthroughSubject`
    var subjectFrutas = PassthroughSubject<String, Never>()

    /// **Paso 1.5** - Diseñar un suscriptor de tipo `AnyCancellable?`
    var suscriptorFrutas: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// **Paso 2** - Para consumir el *sujeto* creamos una suscripción
        ///             del tipo `.sink` la cuál asociará una clausura
        ///             del tipo `(String) -> Void` que nos permite
        ///             establecer que hacer con `String` pasado
        ///             sobre el *sujeto*.
        ///             Cada que el *sujeto* recibe un valor, el suscriptor
        ///             ejecuta la clausura y determina que hacer.
        ///             El resultado será un `AnyCancellable`
        ///             capaz de inhibir al suscriptor para dejar de procesar
        ///             los objetos (de tipo `String`) que están siendo
        ///             recibidos.
        ///  **Nota:** El `suscriptorFrutas` será retenido durante
        ///             el ciclo de vida que deseemos que tenga.
        suscriptorFrutas = subjectFrutas.sink {
            fruta in
            print("Se ha recibido la fruta: \(fruta)")
            self.frutaLabel.text = fruta
        }
        
    }

    @IBAction func enviarFrutaAction(_ sender: Any) {
        
        if let frutaText = frutaTextField.text {
            print("Se desea enviar la fruta \(frutaText) al sujeto")
            
            /// **Paso 3** - Podemos enviarle objetos tipo `String`
            ///             a nuestro *sujeto* para que
            ///             todos los suscriptores los reciban
            ///             y procesen como más les convenga
            subjectFrutas.send(frutaText)
        }
        
    }
    
}

