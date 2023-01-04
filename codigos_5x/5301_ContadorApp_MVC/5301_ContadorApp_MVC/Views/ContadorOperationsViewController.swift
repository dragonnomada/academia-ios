//
//  ContadorOperationsViewController.swift
//  5301_ContadorApp_MVC
//
//  Created by Dragon on 04/01/23.
//

import UIKit

class ContadorOperationsViewController: UIViewController {
    
    @IBOutlet weak var vecesTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        ContadorController.shared.operationsDelegate = self
    }
    
    @IBAction func incrementarAction(_ sender: Any) {
        if let vecesText = vecesTextField.text {
            if let veces = Int(vecesText) {
                ContadorController.shared.incrementar(veces: veces)
            }
        }
        
    }

}

extension ContadorOperationsViewController: ContadorOperationsDelegate {
    func contador(conteoIncremented valor: Int) {
        self.dismiss(animated: true)
    }
    
    func contador(conteoDecremented valor: Int) {
        self.dismiss(animated: true)
    }
    
    func contador(conteoReset valor: Int) {
        self.dismiss(animated: true)
    }
    
    
}
