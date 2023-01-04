//
//  DetailsViewController.swift
//  AHJ_PI_V2
//
//  Created by JonathanA on 29/12/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var event: EventData?
    
    @IBOutlet weak var color: UIView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var inicio: UILabel!
    @IBOutlet weak var end: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = event{
            print("RECIBÍ EL EVENTO \(event)")
            color.backgroundColor = UIColor(hex: event.color)
            // TODO: Redondear la caja
            color.layer.cornerRadius = color.bounds.size.width / 2.0
            eventTitle.text = event.title
            descripcion.text = event.description
            inicio.text = event.startDate.formatted(date: .omitted, time: .shortened)
            end.text = event.endDate.formatted(date: .omitted, time: .shortened)
        }
        
    }
    
    
}
