//
//  HomeViewController.swift
//  4502_Repaso_Combine
//
//  Created by User on 30/12/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var precioLabel: UILabel!
    
    @IBOutlet weak var verDetallesButton: UIButton!
    
    //SUSCRIPTOR DE PLATILLOS
    var platilloSeleccionadoSubsriber: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SUSCRIBO EL SUSCRIPTOR AL SUJETO
        platilloSeleccionadoSubsriber = PlatillosController.shared.platilloSeleccionadoSubject.sink(receiveValue: {
            
            platillo in
            
            self.nombreLabel.text = platillo.nombre
            self.precioLabel.text = ("$\(platillo.precio)")
            
            //YA HAY UN PLATILLO SELECCIONADO
            self.verDetallesButton.isEnabled = true
        })


    }
    

}
