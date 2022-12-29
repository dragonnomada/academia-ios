//
//  NewOrderViewController.swift
//  BJM_PI_v1
//
//  Created by User on 28/12/22.
//

import UIKit

class NewOrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func addDishToOrder(_ sender: Any) {
        
        performSegue(withIdentifier: "ToAddDishInOrder", sender: nil)
    }
    

}
