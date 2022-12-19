//
//  ContactosTableViewController.swift
//  3105_P31_TableView
//
//  Created by User on 19/12/22.
//

import UIKit

///
///  ContactosTableViewController: UITableViewController
///  contiene un `tableView` el cuál está preconfigurado
///  y enlazado al controller.
///
///  Esto significa que el controller necesita explicar cómo se
///  va a representar cada sección, fila y celda en la tabla
///  (protocol UITableViewDataSource)
///  y cómo reaccionar a los eventos de la tabla
///  (protocol UITableViewDelegate)
///
class ContactosTableViewController: UITableViewController {
    
    // TODO: Conectar elementos y demás
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdministradorContactos.shared.agregarContacto(nombre: "Pepe", correo: "pepe@gmail.com", telefono: "+5215512345678")
        AdministradorContactos.shared.agregarContacto(nombre: "Paco", correo: "paco@hotmail.com", telefono: "+5215576453298")
        AdministradorContactos.shared.agregarContacto(nombre: "Luis", correo: "luis@gmail.com", telefono: "+5215589092322")
        AdministradorContactos.shared.agregarContacto(nombre: "Ana", correo: "ana@hotmail.com", telefono: "+5215587676654")
        AdministradorContactos.shared.agregarContacto(nombre: "Bety", correo: "bety@gmail.com", telefono: "+5215592832311")
        AdministradorContactos.shared.agregarContacto(nombre: "Paty", correo: "paty@gmail.com", telefono: "+5215598878423")
        AdministradorContactos.shared.agregarContacto(nombre: "Xantal", correo: "xanti@gmail.com", telefono: "+5215534214343")
        
        tableView.reloadData()
    }
    
}

struct Contacto {
    let id: Int
    let nombre: String
    let correo: String
    let telefono: String
    var titulo: String { "[\(id)] \(nombre)" }
    var subtitulo: String { "<\(correo)> \(telefono)" }
}

class AdministradorContactos {
    static let shared = AdministradorContactos()
    var contactos: [Contacto] = []
    func agregarContacto(nombre: String, correo: String, telefono: String) {
        contactos.append(Contacto(id: contactos.count, nombre: nombre, correo: correo, telefono: telefono))
    }
}

///
/// Ajustar el UITableViewDataSource del TableViewController
/// para explicar cómo se representan los datos en la table
///
extension ContactosTableViewController {
    
    /// Define cuántas secciones hay en la tabla
    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
        let letras = Set(AdministradorContactos.shared.contactos.map({ contacto in contacto.nombre }).map({ nombre in String(describing: nombre.first!)})).sorted()
        print(letras)
        return letras.count
    }
    
    /// Define cuál es el título para cada sección dada
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let letras = Set(AdministradorContactos.shared.contactos.map({ contacto in contacto.nombre }).map({ nombre in String(describing: nombre.first!)})).sorted()
        print(letras)
        return letras[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letras = Set(AdministradorContactos.shared.contactos.map({ contacto in contacto.nombre }).map({ nombre in String(describing: nombre.first!)})).sorted()
        let letra = letras[section]
        let contactos = AdministradorContactos.shared.contactos.filter({ contacto in String(describing: contacto.nombre.first!) == letra })
        return  contactos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let letras = Set(AdministradorContactos.shared.contactos.map({ contacto in contacto.nombre }).map({ nombre in String(describing: nombre.first!)})).sorted()
        let letra = letras[indexPath.section]
        let contactos = AdministradorContactos.shared.contactos.filter({ contacto in String(describing: contacto.nombre.first!) == letra })
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactosTableViewCell")!
        cell.textLabel?.text = contactos[indexPath.row].titulo
        cell.detailTextLabel?.text = contactos[indexPath.row].subtitulo
        return cell
    }
    
}
