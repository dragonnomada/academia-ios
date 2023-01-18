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

class DetallePagoViewController: UIViewController {

    /// Conexion de labels a la vista
    @IBOutlet weak var nombrePagoLabel: UILabel!
    
    @IBOutlet weak var fechaPagoLabel: UILabel!
    
    @IBOutlet weak var sueldoLabel: UILabel!
    
    @IBOutlet weak var viaticosLabel: UILabel!
    
    @IBOutlet weak var prestamoPagoLabel: UILabel!
    
    @IBOutlet weak var abonoPrestamoLabel: UILabel!
    
    @IBOutlet weak var cantidadAbonosLabel: UILabel!
    
    @IBOutlet weak var descripcionPrestamoLabel: UILabel!
    
    @IBOutlet weak var deudaRestanteLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Llamada al delegado (DetallePagoDelegate)
        NominaController.shared.detallePagoDelegate = self
        
    }
        ///Llamada  a la función para obtener el pago seleccionnado
    override func viewWillAppear(_ animated: Bool) {
        NominaController.shared.getPagoSeleccionado()
    }
    
}
///Extensión para la implementación de los metodos traidos por DetallePagoDelegate
extension DetallePagoViewController: DetallePagoDelegate {
    func salario(pagoSeleccionado pago: PagoEntity) {
        
        ///Asignación de los datos a los labels mostrados en pantalla.
        let formatterCurrency = NumberFormatter()
        formatterCurrency.locale = Locale.current
        formatterCurrency.numberStyle = .currency
        
        nombrePagoLabel.text = pago.nombreEmpleado
        
        if let fechaPago = pago.fechaPago {
            fechaPagoLabel.text = fechaPago.toString
        }
        
        sueldoLabel.text = formatterCurrency.string(from: pago.sueldo as NSNumber)
        viaticosLabel.text = formatterCurrency.string(from: pago.viaticos as NSNumber)
        prestamoPagoLabel.text = formatterCurrency.string(from: pago.prestamo as NSNumber)
        cantidadAbonosLabel.text = pago.numeroAbono.toString
        abonoPrestamoLabel.text = formatterCurrency.string(from: pago.cantidadRestantePrestamo as NSNumber)
        descripcionPrestamoLabel.text = pago.descripcionPrestamo
        deudaRestanteLabel.text = formatterCurrency.string(from: pago.prestamo - (pago.cantidadRestantePrestamo * Double(pago.numeroAbono)) as NSNumber)
        
    }
    
    
}
