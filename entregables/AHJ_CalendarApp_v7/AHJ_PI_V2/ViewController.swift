//
//  ViewController.swift
//  AHJ_PI_V2
//
//  Created by MacBook  on 27/12/22.
//

import UIKit

class ViewController: UIViewController {
    // Variable que se vincula con la vista datePicker
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuracion date picker
        // locate: sirve pare definir la internalizacion, hora
        datePicker.locale = .current
        // Configura que funcion se va a ejecutar una vez que el date picker cambie de valor.
        // El primer argument es donde se localiza la funcion con la logicad de negocio.
        // A que evento vamos a reacionar, en este caso vamos a reaccionar al evento de cambio de valor, es decir cuando se seleciona otra fecha.
        datePicker.addTarget(
            self,
            action: #selector(selectDate),
            for: .valueChanged
        )
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToAddEvent", sender: self)
    }
    
    // Sirve para configurar la informacion se se va a pasar a la siguiente view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToAddEvent":
            // Pasa la fechas selecionada a la siguiente view controller
            if let destination = segue.destination as? AddEventViewController {
                destination.selectedDate = datePicker.date
            }
        default:
            print("Invalid segue")
        }
    }

    // Como esta funcion va a ser utilizada por un selector
    // Se tiene que poner la anotacion @objc
    @objc
    func selectDate() {
        print("Arnol \(datePicker.date)")
    }
    
}

