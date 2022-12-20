//
//  ContactoTableViewControler.swift
//  tableView
//
//  Created by MacBook Pro on 19/12/22.
//

import UIKit


class ContactoTableViewControler: UITableViewController {
    override func viewDidLoad() {
        AdministradorContactos.shared.agregarContacto(nombre: "Eduardo", correo: "eduardo@gmail.com", telefono: "555-4231")
        AdministradorContactos.shared.agregarContacto(nombre: "Miguel", correo: "miguel@gmail.com", telefono: "555-5674")
        AdministradorContactos.shared.agregarContacto(nombre: "Sandra", correo: "sandra@gmail.com", telefono: "555-1275")
        AdministradorContactos.shared.agregarContacto(nombre: "Jesus", correo: "luis@gmail.com", telefono: "555-4122")
        AdministradorContactos.shared.agregarContacto(nombre: "Luisa", correo: "fernanda@gmail.com", telefono: "555-0203")
        
        tableView.reloadData()
    }
}

struct Contacto {
    let id: Int
    let nombre: String
    let correo: String
    let telefono: String
    var titulo: String {"\(id) \(nombre)"}
    var subtitulo: String {"\(correo) \(telefono)"}
}

class AdministradorContactos {
    
    static let shared = AdministradorContactos()
    var contactos: [Contacto] = []
    
    func agregarContacto(nombre: String, correo: String, telefono: String){
        contactos.append(Contacto(id: contactos.count, nombre: nombre, correo: correo, telefono: telefono))
    }
    
}


extension ContactoTableViewControler {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todos los Contactos"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AdministradorContactos.shared.contactos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactosTableViewCell")!
//        cell.textLabel?.text = "Soy la celda en la fila \(indexPath.row) de la sección \(indexPath.section)"
//        cell.detailTextLabel?.text = "Hola Mundo"
        cell.textLabel?.text = AdministradorContactos.shared.contactos[indexPath.row].titulo
        
        cell.detailTextLabel?.text = AdministradorContactos.shared.contactos[indexPath.row]
            .subtitulo
        return cell
    }

    
}
