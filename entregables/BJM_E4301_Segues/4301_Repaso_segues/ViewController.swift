//
//  ViewController.swift
//  4301_Repaso_segues
//
//  Created by User on 28/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func irBdeAAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "Ir a B de A", sender: nil)
    }
    
    @IBAction func irCdeAAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "Ir a C de A", sender: nil)
    }
}

