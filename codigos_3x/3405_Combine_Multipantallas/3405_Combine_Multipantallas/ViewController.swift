//
//  ViewController.swift
//  3405_Combine_Multipantallas
//
//  Created by User on 22/12/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var frutaLabel: UILabel!
    
    // Retiene un sujeto capaz de pasar objetos tipo `String`
    var frutasSubject = PassthroughSubject<String, Never>()
    
    // Retiene un suscriptor capaz de hacer "algo" con los objetos de tipo `String`
    var frutasSubscriber: AnyCancellable?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SeleccionarFrutaSegue" {
            
            if let otroViewController = segue.destination as? SeleccionarFrutaViewController {
                
                otroViewController.frutasSubject = self.frutasSubject
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frutasSubscriber = frutasSubject.sink {
            fruta in
            self.frutaLabel.text = fruta
        }
    }


}

