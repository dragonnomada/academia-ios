//
//  SeleccionarFrutaViewController.swift
//  3405_Combine_Multipantallas
//
//  Created by User on 22/12/22.
//

import UIKit
import Combine

class SeleccionarFrutaViewController: UIViewController {

    @IBOutlet weak var frutasPickerView: UIPickerView!
    
    weak var frutasSubject: PassthroughSubject<String, Never>?
    
    var frutas = ["Manzana", "Mango", "Kiwi", "Pera"]
    
    var frutaSeleccionada: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frutasPickerView.dataSource = self
        frutasPickerView.delegate = self
        
        frutaSeleccionada = frutas[0]
    }
    
    @IBAction func cancelarAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func aceptarAction(_ sender: Any) {
        if let frutasSubject = frutasSubject, let frutaSeleccionada = frutaSeleccionada {
            frutasSubject.send(frutaSeleccionada)
            self.dismiss(animated: true)
        }
    }

}

extension SeleccionarFrutaViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frutas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return frutas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        frutaSeleccionada = frutas[row]
    }
    
}
