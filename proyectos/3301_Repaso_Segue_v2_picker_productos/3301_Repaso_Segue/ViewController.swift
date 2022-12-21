//
//  ViewController.swift
//  3301_Repaso_Segue
//
//  Created by User on 21/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    var productoSeleccionado: Producto? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPickerView.dataSource = self
        myPickerView.delegate = self
    }

}

struct Producto {
    let id: Int
    let nombre: String
    let precio: Double
    let existencias: Int
}

class ProductosRepository {
    
    static let main = ProductosRepository()
    
    var productos: [Producto] = [
        Producto(id: 1, nombre: "Coca Cola", precio: 17.5, existencias: 100),
        Producto(id: 2, nombre: "Gansito", precio: 23.0, existencias: 30),
        Producto(id: 3, nombre: "Galletas Oreo", precio: 17.5, existencias: 25),
        Producto(id: 4, nombre: "Chetos", precio: 13.5, existencias: 45),
        Producto(id: 5, nombre: "Churros", precio: 52.99, existencias: 201)
    ]
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ProductosRepository.main.productos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let producto = ProductosRepository.main.productos[row]
        return "\(producto.nombre) $\(producto.precio)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Rodillo \(component) fila \(row)")
        
        let producto = ProductosRepository.main.productos[row]
        
        productoSeleccionado = producto
        
        myButton.isEnabled = true
        
        myLabel.text = "\(producto.nombre) $\(producto.precio)"
    }
    
}
