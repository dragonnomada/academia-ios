//
//  ViewController.swift
//  AHJ_PI_V2
//
//  Created by MacBook  on 27/12/22.
//

import UIKit

class ViewController: UIViewController {
    // Variable que se vincula con la vista datePicker
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventTable: UITableView!
    
    // observedProperty: refresca la tabla cada ves que los datos cambian
    private var selectedDateEvents: [EventData] = []{
        didSet{
            eventTable.reloadData()
        }
    }
    // se ejecuta solo la primera vez que la vista aparece
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuracion date picker
        // locate: sirve pare definir la internalizacion, hora
        datePicker.locale = .current
        // Configura que funcion se va a ejecutar una vez que el date picker cambie de valor.
        // El primer argument es donde se localiza la funcion con la logicad de negocio.
        // A que evento vamos a reacionar, en este caso vamos a reaccionar al evento de cambio de valor, es decir cuando se seleciona otra fecha.
        datePicker.addTarget(
            self,
            action: #selector(selectDate),
            for: .valueChanged
        )
        // Configurar tabla
        eventTable.dataSource = self
        eventTable.delegate = self
    }
    // viewDidAppear se ejecuta cada vez que la vista aparce
    override func viewDidAppear(_ animated: Bool) {
        selectedDateEvents = EventModel.shared.getEvents(date: datePicker.date)
//        eventTable.reloadData()
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToAddEvent", sender: self)
    }
    
    // Sirve para configurar la informacion se se va a pasar a la siguiente view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToAddEvent":
            // Pasa la fechas selecionada a la siguiente view controller
            if let destination = segue.destination as? AddEventViewController {
                destination.selectedDate = datePicker.date
            }
        case "AtoC":
            if let indexPath = eventTable.indexPathForSelectedRow, let destination = segue.destination as? DetailsViewController {
                let event = selectedDateEvents[indexPath.row]
                destination.event = event
            }
        default:
            print("Invalid segue")
        }
    }

    // Como esta funcion va a ser utilizada por un selector
    // Se tiene que poner la anotacion @objc
    @objc
    func selectDate() {
        selectedDateEvents = EventModel.shared.getEvents(date: datePicker.date)
//        eventTable.reloadData()
    }
    
}

// configuracion de donde voy a sacar los datos que se muestran el table view
extension ViewController: UITableViewDataSource{
    // Definir cuantas secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Define cuatas celdas hay por seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateEvents.count
    }
    
    // Rellenar las celdas con los datos correspondientes
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTable.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        let event = selectedDateEvents[indexPath.row]
        
        cell.eventTitle.text = event.title
        cell.color.backgroundColor = UIColor(hex: event.color)
        cell.endDate.text = event.endDate.formatted(date: .omitted, time: .shortened)
        cell.startDate.text = event.startDate.formatted(date: .omitted, time: .shortened)
        return cell
    }
}

// Configuraciones extra de la tabla
extension ViewController: UITableViewDelegate {
    // Navegar a la vista de detalles cuando una fila es selecionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AtoC", sender: nil)
    }
    
    
}
