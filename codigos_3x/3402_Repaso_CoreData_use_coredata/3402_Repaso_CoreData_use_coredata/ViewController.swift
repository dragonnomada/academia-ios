//
//  ViewController.swift
//  3402_Repaso_CoreData_use_coredata
//
//  Created by User on 22/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    var persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let context = persistentContainer?.viewContext {
            print("El contexto ha sido recuperado \(context)")
        }
    }


}

