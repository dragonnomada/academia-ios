//
//  DetallesEmpleadoViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class DetallesEmpleadoViewController: UIViewController {

    
    @IBOutlet weak var empleadoImageView: UIImageView!
    
    @IBOutlet weak var nombreEmpleadoLabel: UILabel!
    
    @IBOutlet weak var idEmpleadoLabel: UILabel!
    
    @IBOutlet weak var empleadoVacacionesLabel: UILabel!
    
    @IBOutlet weak var areaEmpleadoLabel: UILabel!
    
    @IBOutlet weak var departamentoEmpleadoLabel: UILabel!
    
    @IBOutlet weak var prestamoEmpleadoLabel: UILabel!
    
    @IBOutlet weak var antiguedadEmpleadoLabel: UILabel!
    
    @IBOutlet weak var salarioEmpleadoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        empleadoImageView.layer.cornerRadius = empleadoImageView.bounds.size.width / 2.0
        
    }
    
    @IBAction func vacacionesEmpleadoActionButton(_ sender: Any) {
    }
    
    @IBAction func generarPagoEmpleadoActionButton(_ sender: Any) {
    }
    
    @IBAction func nominaEmpleadoActionButton(_ sender: Any) {
    }
    

}
