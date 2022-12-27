//
//  ViewController.swift
//  3303_Apoyo_P33
//
//  Created by User on 21/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView : UITableView!

    weak var persistentContainer: NSPersistentContainer?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "registrarEmpleadoSegue" {
            
            if let registroEmpleadoViewController = segue.destination as? RegistroEmpleadoViewController {
                
                registroEmpleadoViewController.persistentContainer = self.persistentContainer
                
                // Enlazamos este viewController (self)
                // con el otro registroEmpleadoViewController
                registroEmpleadoViewController.viewController = self
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

