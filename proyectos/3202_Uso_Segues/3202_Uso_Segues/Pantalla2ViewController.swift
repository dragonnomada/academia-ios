//
//  Pantalla2ViewController.swift
//  3202_Uso_Segues
//
//  Created by User on 20/12/22.
//

import UIKit

class Pantalla2ViewController : UIViewController {
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        print("Se ejecutá al hacer un unwind segue")
        // TODO: Liberar recursos
        self.dismiss(animated: true)
    }
    
}
