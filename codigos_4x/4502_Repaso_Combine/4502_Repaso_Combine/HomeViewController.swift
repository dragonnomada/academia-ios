//
//  HomeViewController.swift
//  4502_Repaso_Combine
//
//  Created by Dragon on 30/12/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var precioLabel: UILabel!
    
    @IBOutlet weak var verDetallesButton: UIButton!
    
    // SUSCRIPTOR DE PLATILLOS
    var platilloSeleccionadoSubscriber: AnyCancellable?
    
    /*override func viewDidAppear(_ animated: Bool) {
        if let platillo = PlatillosController.shared.getPlatilloSeleccionado() {
            self.nombreLabel.text = platillo.nombre
            self.precioLabel.text = "$\(platillo.precio)"
            
            // YA HAY UN PLATILLO SELECCIONADA
            self.verDetallesButton.isEnabled = true
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(PlatillosController.shared.getPlatilloSeleccionado())
        
        // SUSCRIBO EL SUSCRIPTOR AL SUJETO
        platilloSeleccionadoSubscriber = PlatillosController.shared.platilloSeleccionadoSubject.sink(receiveValue: {
            
            platillo in
            
            self.nombreLabel.text = platillo.nombre
            self.precioLabel.text = "$\(platillo.precio)"
            
            // YA HAY UN PLATILLO SELECCIONADA
            self.verDetallesButton.isEnabled = true
            
        })
    }

}
