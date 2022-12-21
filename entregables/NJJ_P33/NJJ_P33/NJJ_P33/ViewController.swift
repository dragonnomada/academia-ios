//
//  ViewController.swift
//  NJJ_P33
// Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
// Practica p31
// Creado el 21 de Diciembre de 2022
//  Created by MacBook on 21/12/22.
//

import UIKit
import CoreData //Importamos Core data

class ViewController: UIViewController {

    
   
    //le decimos a SceneDelegate que vamos a necesitar de persistentContainer
    var persistentContainer: NSPersistentContainer?
    
    @IBOutlet weak var myTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.reloadData()
    }
//Segue que manda persistentContainer a RegistroEmpleadosView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //identificamos el identificador de mi segue
        if segue.identifier == "segue" {
            //
            if let registrarEmpleado = segue.destination as?
                RegistroEmpleadoViewController {
                //asignamos el persistent container a registrar empleado
                registrarEmpleado.persistentContainer = self.persistentContainer
                //enlazamos este view controller (self)
                //con el otro registroEmpleadoViewConroller
                registrarEmpleado.viewController = self
            }
        }
    }

}//Extension para nuestro datalegate y datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //numero de filas en la secciòn
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Obteniendo número de empleados")
        //creamos nuestro context que va a ser igual a nuestro persistent container.view context
        if let context = persistentContainer?.viewContext {
            //le hacemos una peticiòn a persistentContainer con (fetchRequest) y le asignamos empleados a requestEmpleados
            let requestEmpleados = Empleado.fetchRequest()
            //si si se le asignaron datos a empleados tratamos y contamos el numero de empleados guardados
            if let empleados = try? context.fetch(requestEmpleados) {
                print("Hay \(empleados.count) empleados")
                //Retornamos el numero de empleados
                return empleados.count
            }
            
        }
        //Si no hay datos retornamos cero
        return 0
    }
    //Funciòn para asignarle los datos a mis celdas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Identificamos en que celda se asignaran los datos
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda")!
        //le indicamos que nuestro contexto sera traido de persistentContainer (nuestro modelo con nombre empresa)
        if let context = persistentContainer?.viewContext {
            //almacenamos la entidad empleados traidos por fetch request y lo almacenamos en requestEmpleados
            let requestEmpleados = Empleado.fetchRequest()
            //hacemos un try si es que se recibieron empleados
            if let empleados = try? context.fetch(requestEmpleados) {
                //guardamos el indice de nuestros empleados para cada celda y cada empleado
                let empleado = empleados[indexPath.row]
                //asignamos como titulo el nombre del empleado
                cell.textLabel?.text = empleado.nombre
                //asignamos como subtitulo el salario y el puesto del empleado
                cell.detailTextLabel?.text = "Salario $: \(empleado.salario), Puesto: \(empleado.puesto)"
            }
            
        }
        //retornamos cell con los datos cargados
        return cell
    }
    //Funciòn para asignarle el nombre a la secciòn
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Empleados"
    }
    //Funcion que indica el numero de secciones (1)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

