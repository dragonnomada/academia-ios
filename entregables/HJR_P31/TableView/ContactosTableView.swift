//
//  ContactostableView.swift
//  TableView
//
//  Created by MacBook on 19/12/22.
//

import UIKit

/*
class ContactosTableView: UITableView, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Hola")
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactosTableViewCell")!
        cell.textLabel!.text = "Hola"
        cell.detailTextLabel!.text = "mundo"
        
        return cell
    }
}
 */



class ContactosTableViewController: UITableViewController {
    
    // TODO: Conectar elementos y demás
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdministradorContactos.shared.agregarContacto(nombre: "Juan", correo: "juan@gmail.com", telefono: "+5212345678")
        AdministradorContactos.shared.agregarContacto(nombre: "Emiliano", correo: "emiliano@gmail.com", telefono: "+5255789304")
        AdministradorContactos.shared.agregarContacto(nombre: "Nathaly", correo: "nathaly@gmail.com", telefono: "+525587390568")
    }
    
}

struct Contacto {
    let id: Int
    let nombre: String
    let correo: String
    let telefono: String
    var titulo: String { "[\(id)] \(nombre)"}
    var subtitulo: String { "<\(correo)> \(telefono)"}
}

class AdministradorContactos {
    
    // Singleton
    static let shared = AdministradorContactos()
    
    // Arreglo donde se guardaran todos los contactos
    var contactos: [Contacto] = []
    
    // Función para agregar contactos al arreglo.
    func agregarContacto(nombre: String, correo: String, telefono: String) {
        
        contactos.append(Contacto(id: contactos.count, nombre: nombre, correo: correo, telefono: telefono))
    }
}



// Como se comporta el tableViewDataSource

// Ajusta el UITableViewDataSource del TableViewController
// para explicar como se representan los datos de la table.
extension ContactosTableViewController {
    
    // Define cuantas secciones hay en la tabla
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Define cuál es el título para cada sección dada
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todos los contactos"
    }
    
    // Define cuantas filas tendra cada sección
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AdministradorContactos.shared.contactos.count
    }
    
    // Modifica el contenido de la celda
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Identificador de el tableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactosTableViewCell")!
        //cell.textLabel?.text = "Soy la celda en la fila \(indexPath.row) de la seccion \(indexPath.section)"
        cell.textLabel?.text = AdministradorContactos.shared.contactos[indexPath.row].titulo
        cell.detailTextLabel?.text = AdministradorContactos.shared.contactos[indexPath.row].subtitulo

        //cell.detailTextLabel?.text = "Hola!!!"
        return cell
    }
}

