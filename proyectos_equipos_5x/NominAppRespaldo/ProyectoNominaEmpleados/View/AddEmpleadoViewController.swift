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

class AddEmpleadoViewController: UIViewController {

    
    @IBOutlet weak var imagenPerfilEmpleado: UIImageView!
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var areaTextField: UITextField!
    
    @IBOutlet weak var departamentoTextField: UITextField!
    
    @IBOutlet weak var puestoTextField: UITextField!
    
    @IBOutlet weak var salarioTextField: UITextField!
    
    var fechaContratacion: Date? = Date.now
    
    @IBAction func addFechaContratacionActionButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Hacemos curva la imagen, tiene que ser cuadrada para que sea totalmente redonda
        imagenPerfilEmpleado.layer.cornerRadius = imagenPerfilEmpleado.bounds.size.width / 2.0
        
        ///Instanciamos el delegado del controllador para agregar empleados.
        NominaController.shared.addEmpleadoDelegate = self
        
        
    }
    
    @IBAction func guardarActionButton(_ sender: Any) {
        ///Alerta
        let alert = UIAlertController(title: "Atención", message: "¿ Desea guardar al empleado ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            /// Asignación de los datos en los textfields
            guard let nombre = self.nombreTextField.text else {
                return self.empleado(empleadoCreadoError: "Error, el nombre es requerido")
            }
            
            guard let area = self.areaTextField.text else {
                return self.empleado(empleadoCreadoError: "Error, el area es requerida")
            }
            
            guard let departamento = self.departamentoTextField.text
            else {
                return self.empleado(empleadoCreadoError: "Error el departamento es requerido")
            }
            
            guard let puesto = self.puestoTextField.text
            else {
                return self.empleado(empleadoCreadoError: "Error, el puesto es requerido")
            }
            
            guard let salario = self.salarioTextField.text
            else {
                return self.empleado(empleadoCreadoError: "Error, el salario es requerido")
            }
            
            guard let fechaContratacion = self.fechaContratacion else {
                return self.empleado(empleadoCreadoError: "Error, la fecha es requerido")
            }
            ///Guardos al empleado con los datos de los textfields.
            NominaController.shared.addEmpleado(id: Int(Int32.random(in: 1...Int32.max)), nombre: nombre, area: area, departamento: departamento, puesto: puesto, fechaContratacion: fechaContratacion, salario: Double(salario) ?? 0.0)
            NSLog("Empleado Guardado")
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Guardar Empleado Cancelado")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
        
    @IBAction func cancelarActionButton(_ sender: Any) {
        ///Función para cancelar y salir de la pantalla
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
<<<<<<< HEAD
///Extension para la implementación de los metodos de AddEmpleadoDelegate.
=======

>>>>>>> 7840d4b84fb66e939871412a5151249f3d8f3ab6
extension AddEmpleadoViewController: AddEmpleadoDelegate {
    
    func empleado(fechaContratado fecha: Date) {
        print("FECHA CONTRATACIÓN: \(fecha)")
        self.fechaContratacion = fecha
    }
    
    func empleado(empleadoCreado empleado: EmpleadoEntity) {
        print("Empleado Creado Correctamente \(empleado)")
        self.navigationController?.popViewController(animated: true)
    }
    
    func empleado(empleadoCreadoError message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                
                self.present(alert, animated: true)
    }
    
}
