//
// Proyecto: NominApp
//
// Autores:
// Joel Brayan Navor Jimenez
// Brian Jimenez Moedano
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 3 de enero del 2023
//

import UIKit

class CalendarioViewController: UIViewController {

    
    @IBOutlet weak var calendarioDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // El calendarioDelegate sera esta vista
        NominaController.shared.calendarioDelegate = self
        
        calendarioDatePicker.locale = .current
        calendarioDatePicker.date = Date()
        calendarioDatePicker.addTarget(self, action: #selector(selectDate), for: .valueChanged)
    }
    
    @objc
    func selectDate() {
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .medium
        //dateFormatter.timeStyle = .none
        //let date = dateFormatter.string(from: calendarioDatePicker.date)
        print("-----------------------------")
        print(calendarioDatePicker.date)
        NominaController.shared.seleccionarFecha(fechaSeleccionada: calendarioDatePicker.date)
        
    }
    

    @IBAction func guardarDateCalendario(_ sender: Any) {
        
        let alert = UIAlertController(title: "Atención", message: "¿ Desea guardar la fecha ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Saliendo ..."); self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Quedarse")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelarAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Atención", message: "¿ Desea salir de la pantalla ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Saliendo ..."); self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Quedarse")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    

}

extension CalendarioViewController:
    
    CalendarioDelegate {
    
    func empleado(fechaSeleccionada fecha: Date) {
    }
    
    func empleado(fechaSeleccionadaError message: String) {
    }
    
    
}
