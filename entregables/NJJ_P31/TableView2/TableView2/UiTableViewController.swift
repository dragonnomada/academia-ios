//
//  UiTableViewController.swift
//  TableView2
//
//  Created by MacBook on 19/12/22.
//

import UIKit



struct Contacto {
    let id: Int
    let nombre: String
    let correo: String
    let telefono: String
    var titulo: String { "[\(id)] \(nombre)" }
    var subtitulo: String {" \(correo), \(telefono) "}
}
class AdministrarContactos {
    static let shared = AdministrarContactos()
    var contactos: [Contacto] = []
    func agregarContacto(nombre: String, correo: String, telefono: String) {
        contactos.append(Contacto(id: contactos.count, nombre: nombre, correo: correo, telefono: telefono))
    }
}

class ContactosTableViewController:UITableViewController {
        
    override func viewDidLoad() {
        AdministrarContactos.shared.agregarContacto(nombre: "Paco", correo: "asda@gmail.com", telefono: "+2451623182")
        AdministrarContactos.shared.agregarContacto(nombre: "Pedro", correo: "rupert@gmail.com", telefono: "1234123124")
        AdministrarContactos.shared.agregarContacto(nombre: "Juan", correo: "lola@gmail.com", telefono: "1231241245")
        AdministrarContactos.shared.agregarContacto(nombre: "Carlos", correo: "carlosa@gmail.com", telefono: "1231241234")
        AdministrarContactos.shared.agregarContacto(nombre: "Hernesto", correo: "pedroa@gmail.com", telefono: "1231234123")
        AdministrarContactos.shared.agregarContacto(nombre: "Karla", correo: "assadaa@gmail.com", telefono: "2312341234")
    }
        }
    
//Como se comporta table view data source
///Ajustar el UITableDataSourceViewController
///para explicar còmo se representan los datos en la tabla
extension ContactosTableViewController {
    
    ///Define cuantas secciones hay en la tabla
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    ///Define cual es el titulo para cada secciòn dada
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todos los contactos"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AdministrarContactos.shared.contactos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactosTableViewCell")!
        cell.textLabel?.text = AdministrarContactos.shared.contactos[indexPath.row].titulo
        cell.detailTextLabel?.text = AdministrarContactos.shared.contactos[indexPath.row].subtitulo
        return cell
    }
    
}


