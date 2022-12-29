//
//  AddEventViewController.swift
//  AHJ_PI_V2
//
//  Created by JonathanA on 27/12/22.
//

import UIKit

class AddEventViewController: UIViewController {
    var selectedDate: Date?

    @IBOutlet weak var colorwell: UIColorWell!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var endDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure date pickers
        startDate.locale = .current
        endDate.locale = .current
        if let date = selectedDate {
            startDate.date = date
            endDate.date = date
        }
        
        // Configurar colorwell
        colorwell.selectedColor = .red
    }

    @IBAction func createEvent(_ sender: Any) {
        if
            let title = titleTextField.text,
            let description = textDescription.text,
            let color = colorwell.selectedColor,
            !title.isEmpty,
            !description.isEmpty {
            AddEventViewModel.shared.createEventSubject.send(
                (
                    title: title,
                    description: description,
                    color: color.toHex!,
                    startDate: startDate.date,
                    endDate: endDate.date
                )
            )
        }
        
    }
    
}
