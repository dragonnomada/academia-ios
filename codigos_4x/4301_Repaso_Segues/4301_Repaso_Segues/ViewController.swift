//
//  ViewController.swift
//  4301_Repaso_Segues
//
//  Created by Dragon on 28/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func irBAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "AtoB", sender: nil)
        
    }
    
}

