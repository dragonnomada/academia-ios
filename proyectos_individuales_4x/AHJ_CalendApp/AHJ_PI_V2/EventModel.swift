//
//  EventModel.swift
//  AHJ_PI_V2
//
//  Created by JonathanA on 27/12/22.
//

import Foundation


// La Logica de negocio y datos van en esta clase


class EventModel {
    static var shared = EventModel()
    
    var events: [EventData] = [
        EventData(title: "Prueba", description: "Evento de prueba hoy", color: "FF00FF", startDate: Date.now, endDate: Date.now)
    ]
    
    private init() {
    }
    
    // Convertir una fecha en un string, dia/mes/año
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    func addEvent(title: String, description: String, color: String, startDate: Date, endDate: Date) {
        let newEvent = EventData(title: title, description: description, color: color, startDate: startDate, endDate: endDate)
        events.append(newEvent)
    }
    
    func getEvents(date: Date) -> [EventData] {
        let dateStr = convertDateToString(date: date)
        var filterEvents: [EventData] = []
        for event in events {
            let eventDateStr = convertDateToString(date: event.startDate)
            if  eventDateStr == dateStr {
                filterEvents.append(event)
            }
        }
        return filterEvents
    }
}
