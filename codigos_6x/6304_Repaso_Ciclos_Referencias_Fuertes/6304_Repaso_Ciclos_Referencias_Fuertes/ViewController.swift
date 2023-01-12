//
//  ViewController.swift
//  6304_Repaso_Ciclos_Referencias_Fuertes
//
//  Created by Dragon on 11/01/23.
//

import UIKit

func citaDelDia(autor: String, complete: (String) -> Void) {
    
    Thread.sleep(forTimeInterval: 10)
    
    let cita = "\(autor) dice: Ama y serás amado \(Date.now)"
    
    complete(cita)
    
}

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myLabel.text = "Hola"
        
        // BLOQUEA EL HILO PRINCIPAL
        /*citaDelDia(autor: "Séneca") { cita in
            self.myLabel.text = cita
        }*/
        
        // .reloadData()
        
        /*DispatchQueue.main.async {
            // ~ .reloadData()
            citaDelDia(autor: "Séneca") { cita in
                self.myLabel.text = cita
            }
        }*/
        
        /*citaDelDia(autor: "Séneca") { cita in
            DispatchQueue.main.async {
                self.myLabel.text = cita
            }
        }*/
        
        if let url = URL(string: "https://googlex.com") {
            
            //print(self.myLabel.text) // :)
            
            // SCOPE <= VIEWCONTROLLER (ESCENARIO DE MEMORIA + HILO)
            
            let session = URLSession.shared.dataTask(with: url) {
                [unowned self] data, response, error in
                
                // SCOPE <= CLAUSURA (OTRO ESCENARIO DE MEMORIA + HILO)
                
                if let error = error {
                    DispatchQueue.main.async {
                        // SCOPE <= MAIN (OTRA CLAUSURA)
                        [weak self] in
                        self?.myLabel.text = "Error :/ (\(error)"
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        [weak self] in
                        self?.myLabel.text = "Sin datos >:("
                    }
                    return
                }

                DispatchQueue.main.async {
                    [weak self] in
                    self?.myLabel.text = "\(data)"
                    // GARANTIZAR QUE NO HAY CICLO REFERENCIAL EN SELF
                }
                //self.myLabel.text = String(data: data, encoding: .utf8)
                
            }
            
            session.resume()
            
        }
        
    }


}

