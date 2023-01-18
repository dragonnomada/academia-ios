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
        
        NominaController.shared.detallesEmpleadoDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NominaController.shared.getEmpleadoSeleccionado()
    }
    
    @IBAction func vacacionesEmpleadoActionButton(_ sender: Any) {
    }
    
    @IBAction func generarPagoEmpleadoActionButton(_ sender: Any) {
    }
    
    @IBAction func nominaEmpleadoActionButton(_ sender: Any) {
        
    }
    

}

extension DetallesEmpleadoViewController: DetallesEmpleadoDelegate {
    
    func empleado(empleadoSeleccionado empleado: EmpleadoEntity) {
        
        // Creamos diferentes formatters para representar datos tipo Date y Double en
        // forma de String más comprensibles para el usuario
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let formatterTimeAgo = DateFormatter()
        formatterTimeAgo.dateFormat = "yyyyMMdd"
        
        let formatterCurrency = NumberFormatter()
        formatterCurrency.locale = Locale.current
        formatterCurrency.numberStyle = .currency
        
        // Usamos una variable auxiliar para facilitar el desengrapado y uso de la variable
        // tienePrestamos del empleado seleccionado
        var tienePrestamo: Bool
        
        if let unwrapTienePrestamo = NominaController.shared.model.empleadoSeleccionado?.tienePrestamo {
            
            tienePrestamo = unwrapTienePrestamo
        } else {
            
            tienePrestamo = false
        }
        
        // Actualiza la Vista con los datos que recibimos del empleado seleccionado (Controller)
        nombreEmpleadoLabel.text = NominaController.shared.model.empleadoSeleccionado?.nombre
        
        idEmpleadoLabel.text = String(Int(NominaController.shared.model.empleadoSeleccionado?.id ?? 0))
        
        empleadoVacacionesLabel.text = "\(formatter.string(from: NominaController.shared.model.empleadoSeleccionado?.fechaVacacionesInicio ?? Date.now)) - \(formatter.string(from: NominaController.shared.model.empleadoSeleccionado?.fechaVacacionesFin ?? Date.now))"
        
        areaEmpleadoLabel.text = NominaController.shared.model.empleadoSeleccionado?.area
        
        departamentoEmpleadoLabel.text = NominaController.shared.model.empleadoSeleccionado?.departamento
        
        if tienePrestamo {
            
            prestamoEmpleadoLabel.text = "Sí"
        } else {
            
            prestamoEmpleadoLabel.text = "No"
        }
        antiguedadEmpleadoLabel.text = "\(Int(formatterTimeAgo.string(from: Date.now))! - Int(formatterTimeAgo.string(from: NominaController.shared.model.empleadoSeleccionado?.fechaContratacion ?? Date.now))!) días"
//        String(Int(NominaController.shared.model.empleadoSeleccionado?.antiguedad ?? 0))
        
        salarioEmpleadoLabel.text = formatterCurrency.string(for: NominaController.shared.model.empleadoSeleccionado?.salario ?? 0.0)
        //String(NominaController.shared.model.empleadoSeleccionado?.salario ?? 0.0)
    }
    
    func empleado(vacacionesSeleccionadas vacaciones: Date, tipoFecha tipo: TipoFecha) {
        
    }

}
