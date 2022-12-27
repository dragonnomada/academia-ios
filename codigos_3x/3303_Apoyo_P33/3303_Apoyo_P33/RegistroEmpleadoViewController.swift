//
//  RegistroEmpleadoViewController.swift
//  3303_Apoyo_P33
//
//  Created by User on 21/12/22.
//

import UIKit
import CoreData

class RegistroEmpleadoViewController: UIViewController {

    weak var persistentContainer: NSPersistentContainer?
    
    weak var viewController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmarAction(_ sender: Any) {
        // TODO: Guardar un nuevo Empleado en el persistentContainer
        
        // Actualizar la tabla
        viewController?.myTableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
