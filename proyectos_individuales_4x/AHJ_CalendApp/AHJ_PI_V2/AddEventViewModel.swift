//
//  AddEventViewModel.swift
//  AHJ_PI_V2
//
//  Created by JonathanA on 28/12/22.
//

import Foundation
import Combine

class AddEventViewModel {
    static var shared = AddEventViewModel()
    // emisor de platillos
    var createEventSubject = PassthroughSubject<(title: String, description: String, color: String, startDate: Date, endDate: Date), Never>()
    var createEventSubscriber: AnyCancellable
    
    private init() {
        createEventSubscriber = createEventSubject.sink { (title: String, description: String, color: String, startDate: Date, endDate: Date) in
            EventModel.shared.addEvent(title: title, description: description, color: color, startDate: startDate, endDate: endDate)
        }
    }
}
