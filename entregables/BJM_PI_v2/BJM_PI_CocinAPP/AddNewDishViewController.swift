//
//  AddNewDishViewController.swift
//  BJM_PI_v1
//
//  Created by User on 28/12/22.
//

import UIKit

class AddNewDishViewController: UIViewController {
    
    @IBOutlet weak var newDishName: UITextField!
    
    @IBAction func addNewDish(_ sender: Any) {
        
        if newDishName.text != "" {
            
            AvailableDish.shared.addNewDish(Dish(nombre: newDishName.text!))
            self.navigationController?.popViewController(animated: true)

            /*for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: HomeViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }*/
            
        } else {
            let errorAddNewDish = UIAlertController(title: "Error", message: "Nombre del platillo está vacío.", preferredStyle: .alert)
            errorAddNewDish.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(errorAddNewDish, animated: true)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
}
