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

class HistorialNominaViewController: UIViewController {

    
    @IBOutlet weak var myTableView: UITableView!
    
    var pagos: [PagoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NominaController.shared.historialNominaDelegate = self
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        NominaController.shared.obtenerHistorialPagos()
    }
}

extension HistorialNominaViewController: HistorialNominaDelegate {
    
    func pago(historialPagos historial: [PagoEntity]) {
        self.pagos = historial
        self.myTableView.reloadData()
    }
    
    func pago(pagoSeleccionado: PagoEntity, index: Int) {
        
        //cuando el modelo actualice el pago seleccionado, el controlador
        //notifica si la acción se realizó correctamente, para que la vista
        //pueda (o no), actualizarse con un perform segue.
        if let _ = NominaController.shared.model.pagoSeleccionado{
            
            self.performSegue(withIdentifier: "GoDetallesPagoVC", sender: nil)
        }
    }
}

extension HistorialNominaViewController: UITableViewDataSource {
    
    // Numero de secciones que se requiere pintar en la celda
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Cantidad de elementos que se requieren en la seccion deseada
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagos.count
    }
    
    // Titulo deseado en cada seccion
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Historial de Pagos"
    }
    
    // Configuracion de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NominasCell")!
        let pago = self.pagos[indexPath.row]
        
        // Creamos diferente un formatter para representar datos tipo Date en
        // forma de String más comprensibles para el usuario
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let formatterCurrency = NumberFormatter()
        formatterCurrency.locale = Locale.current
        formatterCurrency.numberStyle = .currency
        
        if let customCell = cell as? NominaCustomTableViewCell {
            customCell.nombreNominaLabel.text = pago.nombreEmpleado
            customCell.fechaPagoLabel.text = formatter.string(from: pago.fechaPago ?? Date.now)
            customCell.cantidadLabel.text = formatterCurrency.string(from: pago.sueldo + pago.viaticos - pago.cantidadRestantePrestamo as NSNumber)
        }
        
        return cell
    }
}

extension HistorialNominaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NominaController.shared.seleccionarPago(index: indexPath.row, pago: NominaController.shared.model.pagoSeleccionado ?? PagoEntity().self)
    }
    
}
