//
//  HomeViewController.swift
//  BJM_PI_v1
//
//  Created by User on 28/12/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createNewOrder(_ sender: Any) {
        
        performSegue(withIdentifier: "ToAddOrder", sender: nil)
    }
    
    
    
    @IBAction func createDish(_ sender: Any) {
        
        performSegue(withIdentifier: "ToAddNewDish", sender: nil)
    }
    
    
}
