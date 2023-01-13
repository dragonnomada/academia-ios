//
//  StoreAddViewController.swift
//  6202_StoreApp_MVVM
//
//  Created by Dragon on 10/01/23.
//

import UIKit

class StoreAddViewController: UIViewController {

    var viewModel = StoreAddViewModel()
    
    @IBOutlet weak var fruitNameTextField: UITextField!
    
    @IBOutlet weak var fruitAmountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.view = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.viewModel.unsubscribe()
    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        self.viewModel.view = nil
    }*/
    
    @IBAction func fruitAddAction() {
        print("Se agregará una fruta")
        
        guard let nameText = fruitNameTextField.text else {
            // TODO: Avisa que nombre es nil
            return
        }
        
        guard nameText != "" else {
            // TODO: Avisa que nombre está vacío
            return
        }
        
        guard let amountText = fruitAmountTextField.text else {
            // TODO: Avisa que no tiene cantidad
            return
        }
        
        guard let amount = Double(amountText) else {
            // TODO: Avisa que la cantidad no es Double
            return
        }
        
        guard amount > 0 else {
            // TODO: Avisa que la cantidad no es positiva
            return
        }
        
        print("Agregando fruta: \(nameText) [\(amount) kg]")
        
        self.viewModel.addFruit(name: nameText, amount: amount)
        
    }

}

extension StoreAddViewController: StoreAddView {
    
    func fruits(fruitAdded fruit: FruitEntity) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
