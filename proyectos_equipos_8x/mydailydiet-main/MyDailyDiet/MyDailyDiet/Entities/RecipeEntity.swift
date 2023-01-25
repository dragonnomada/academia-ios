//
//  RecipeEntity.swift
//  MyDailyDiet
//
//  Created by MacBook on 23/01/23.
//

import Foundation

struct RecipeResponse: Decodable {
    
    var hints: [Recipes]
    
}

struct Recipes: Decodable {
    
    var food: RecipeInfo
    
}

struct RecipeInfo: Decodable {
    
    let foodId: String
    let nutrients: RecipeNutrients
    let brand: String
    let category: String
    
}

struct RecipeNutrients: Decodable {
    
    let ENERC_KCAL: Double
    let PROCNT: Double
    let FAT: Double
    let CHOCDF: Double
    let FIBTG: Double
    
}
