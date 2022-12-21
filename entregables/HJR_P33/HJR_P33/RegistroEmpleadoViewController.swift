/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 21-12-22
 
 Práctica 33 - Uso de Core Data y persistencia
 */
import UIKit
import CoreData

// Clase Registro empleaod
class RegistroEmpleadoViewController: UIViewController {
    
    var persistentContainer: NSPersistentContainer?
    
    var viewController: ViewController?
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var edadTextField: UITextField!
    
    @IBOutlet weak var telefonoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // Funcion que carga los empleados a la lista de la vista principal
    func cargarEmpleados() {
        if let context = persistentContainer?.viewContext {
            
            let requestEmpleados = Empleado.fetchRequest()
            
            if let empleados = try? context.fetch(requestEmpleados) {
                
                for empleado in empleados {
                    
                    print("El Empleado con id [\(empleado.id)], nombre \(empleado.nombre!) \(empleado.edad) \(empleado.telefono)")
                    print("-----------------------------------------------------")
                }
                print("->->->->->->->->->->->->->->->->->->->->->->->-")
            }
        }
    }
    
    
    // Funcion que guarda los empleados 
    @IBAction func guardarEmpleados(_ sender: Any) {
        
        if let context = persistentContainer?.viewContext {
            let empleado = Empleado(context: context)
            
            empleado.id = Int32.random(in: 1...100)
            empleado.nombre = nombreTextField.text
            empleado.edad = Int32(edadTextField.text ?? "0") ?? 0
            empleado.telefono = Int32(telefonoTextField.text ?? "0") ?? 0
            
            do {
                try context.save()
                print("Empleado guardado")
                // Resetear los textField
                idTextField.text = ""
                nombreTextField.text = ""
                edadTextField.text = ""
                telefonoTextField.text = ""
                // Nos regresa al campo de nombreTextField
                idTextField.becomeFirstResponder()
                // Manadr a llamar par actualizar productos
                cargarEmpleados()
            } catch {
                context.rollback()
                print("No se pudo guardar el proyecto")
            }
        }
        
    }
}
