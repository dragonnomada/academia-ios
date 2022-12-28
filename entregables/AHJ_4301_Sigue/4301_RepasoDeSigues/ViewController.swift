//
//  ViewController.swift
//  4301_RepasoDeSigues
//
//  Created by MacBook  on 28/12/22.
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
    
    @IBAction func AtoC(_ sender: Any) {
        self.performSegue(withIdentifier: "AtoC", sender: nil)
    }
}

