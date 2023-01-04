//
//  ContadorHomeViewController.swift
//  5301_ContadorApp_MVC
//
//  Created by Dragon on 04/01/23.
//

import UIKit

class ContadorHomeViewController: UIViewController {

    @IBOutlet weak var conteoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContadorController.shared.homeDelegate = self
        ContadorController.shared.actualizar()
    }

}

extension ContadorHomeViewController: ContadorHomeDelegate {
    
    func contador(conteoUpdated valor: Int) {
        self.conteoLabel.text = "[ \(valor) ]"
    }
    
}
