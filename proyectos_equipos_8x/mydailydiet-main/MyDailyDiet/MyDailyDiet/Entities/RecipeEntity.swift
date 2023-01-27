//
//  RecipeEntity.swift
//  MyDailyDiet
//
//  Created by MacBook on 23/01/23.
//

import Foundation
import UIKit

struct RecipeResponse: Decodable {
    
    var hits: [RecipeHit] = []
    
}

struct RecipeHit: Decodable {
    
    let recipe: RecipeDetails
    
}

struct RecipeDetails: Decodable {
    
    let label: String
    let images: ImageRecipeSize
    let ingredientLines: [String]
    let calories: Double
    let mealType: [String]
    let totalNutrients: IngredientNutrients
    
}

struct ImageRecipeSize: Decodable {
    
    let THUMBNAIL: ImageSource
    let SMALL: ImageSource
    let REGULAR: ImageSource
    
}

struct ImageSource: Decodable {
    
    let url: String
    
}

struct IngredientNutrients: Decodable {
    

    let ENERC_KCAL: IngredientMeasure
    let FAT: IngredientMeasure
    let FASAT: IngredientMeasure
    let FATRN: IngredientMeasure
    let FAMS: IngredientMeasure
    let FAPU: IngredientMeasure
    let CHOCDF: IngredientMeasure
    let CHOCDFN: IngredientMeasure
    let FIBTG: IngredientMeasure
    let SUGAR: IngredientMeasure
    let SUGARN: IngredientMeasure
    let SUGARA: IngredientMeasure
    let PROCNT: IngredientMeasure
    let CHOLE: IngredientMeasure
    let NA: IngredientMeasure
    let CA: IngredientMeasure
    let MG: IngredientMeasure
    let K: IngredientMeasure
    let FE: IngredientMeasure
    let ZN: IngredientMeasure
    let P: IngredientMeasure
    let VITA_RAE: IngredientMeasure
    let VITC: IngredientMeasure
    let THIA: IngredientMeasure
    let RIBF: IngredientMeasure
    let NIA: IngredientMeasure
    let VITB6A: IngredientMeasure
    let FOLDFE: IngredientMeasure
    let FOLFD: IngredientMeasure
    let FOLAC: IngredientMeasure
    let VITB12: IngredientMeasure
    let VITD: IngredientMeasure
    let TOCPHA: IngredientMeasure
    let VITK1: IngredientMeasure
    let WATER: IngredientMeasure

    
    
    enum CodingKeys: String, CodingKey {
        
        case ENERC_KCAL = "ENERC_KCAL"
        case FAT = "FAT"
        case FASAT = "FASAT"
        case FATRN = "FATRN"
        case FAMS = "FAMS"
        case FAPU = "FAPU"
        case CHOCDF = "CHOCDF"
        case CHOCDFN = "CHOCDF.net"
        case FIBTG = "FIBTG"
        case SUGAR = "SUGAR"
        case SUGARN = "SUGAR.added"
        case SUGARA = "Sugar.alcohol"
        case PROCNT = "PROCNT"
        case CHOLE = "CHOLE"
        case NA = "NA"
        case CA = "CA"
        case MG = "MG"
        case K = "K"
        case FE = "FE"
        case ZN = "ZN"
        case P = "P"
        case VITA_RAE = "VITA_RAE"
        case VITC = "VITC"
        case THIA = "THIA"
        case RIBF = "RIBF"
        case NIA = "NIA"
        case VITB6A = "VITB6A"
        case FOLDFE = "FOLDFE"
        case FOLFD = "FOLFD"
        case FOLAC = "FOLAC"
        case VITB12 = "VITB12"
        case VITD = "VITD"
        case TOCPHA = "TOCPHA"
        case VITK1 = "VITK1"
        case WATER = "WATER"
        
    }
    
}

struct IngredientMeasure: Decodable {
    
    let label: String
    let quantity: Double
    let unit: String
    
}



/*
 // ---- PRUEBA 1
 
 
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
 */
