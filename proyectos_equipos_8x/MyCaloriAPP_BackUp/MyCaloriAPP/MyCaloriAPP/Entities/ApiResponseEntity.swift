//
//  ApiResponseEntity.swift
//  MyCaloriAPP
//
//  Created by User on 24/01/23.
//

import Foundation


struct ApiResponseEntity: Decodable {
    
    let parsed: [ApiParsedEntity]
}

struct ApiParsedEntity: Decodable {
    
    let food: ApiFoodEntity
}

struct ApiFoodEntity: Decodable {
    
    let foodId: String
    let label: String
    let knownAs: String
    let nutrients: ApiNutrientsEntity
    let image: String
}

struct ApiNutrientsEntity: Decodable {
    
    let calories: Double
    let proteins: Double
    let fats: Double
    let carbs: Double
    let fiber: Double
    
    enum CodingKeys: String, CodingKey {
        
        case calories = "ENERC_KCAL"
        case proteins = "PROCNT"
        case fats = "FAT"
        case carbs = "CHOCDF"
        case fiber = "FIBTG"
    }
}
