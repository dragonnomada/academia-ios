//
//  EventData.swift
//  AHJ_PI_V2
//
//  Created by JonathanA on 27/12/22.
//

import Foundation

struct EventData: Identifiable {
    let id: UUID = UUID() // Auto genera el identificar ocupando un uuid.
    let title: String
    let description: String
    let color: String
    let startDate: Date
    let endDate: Date
}
