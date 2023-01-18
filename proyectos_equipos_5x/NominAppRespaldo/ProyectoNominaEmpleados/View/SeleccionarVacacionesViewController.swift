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

class SeleccionarVacacionesViewController: UIViewController {
    
    @IBOutlet weak var fechaInicioVacacionesLabel: UILabel!
    
    @IBOutlet weak var fechaFinVacacionesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        NominaController.shared.seleccionarVacacionesDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NominaController.shared.getEmpleadoSeleccionadoFechasVacaciones()
    }
    
    @IBAction func aceptarFechasVacacionesActionButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Atención", message: "¿ Los datos son correctos ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            NominaController.shared.guardarFechasEmpleadoSeleccionado()
            NSLog("Saliendo ..."); self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Quedarse")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func inicioVacacionesAction(_ sender: Any) {
        
        NominaController.shared.seleccionarTipoFechaComoInicioVacaciones()
        
    }
    
    @IBAction func finVacacionesAction(_ sender: Any) {
        
        NominaController.shared.seleccionarTipoFechaComoFinVacaciones()
    }
    
    
}

extension SeleccionarVacacionesViewController: SeleccionarVacacionesDelegate {
    
    func empleado(fechaSeleccionada fecha: Date, tipoFecha tipo: TipoFecha) {
        print("RECIBIENDO FECHAS DE VACACIONE")
        switch tipo {
        case .inicioVacaciones:
            fechaInicioVacacionesLabel.text = "\(fecha)"
            NominaController.shared.addFechaInicioVacaciones(fecha: fecha)
        case .finVacaciones:
            fechaFinVacacionesLabel.text = "\(fecha)"
            NominaController.shared.addFechaFinVacaciones(fecha: fecha)
        default:
            print("Tiop no válido")
        }
        print("FECHA CONTRATACIÓN: \(fecha) tipo fecha \(tipo)")
        
    }
}
