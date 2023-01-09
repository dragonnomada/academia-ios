//
//  ViewController.swift
//  6101_Combine
//
//  Created by Dragon on 09/01/23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    /// Creamos un publicador de tipo `Bool/Never`
    @Published var encendido: Bool = true
    
    /// Creamos un suscriptor genérico de tipo `AnyCancellable`
    var encendidoSubscriber: AnyCancellable? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.encendido = self.mySwitch.isOn
        
        // Conectamos el suscriptor al publicador
        self.encendidoSubscriber = self.$encendido.sink {
            valor in
            // Hacemos la lógica con el valor recibido desde el publicador y procesado por el suscriptor
            print("Se ha cambiado encendido: \(valor)")
            
            self.myLabel.text = valor ? "ENCENDIDO" : "APAGADO"
        }
    }
    
    @IBAction func changeSwitchAction() {
        self.encendido = self.mySwitch.isOn
    }

}

