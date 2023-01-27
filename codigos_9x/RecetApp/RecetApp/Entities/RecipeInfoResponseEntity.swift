//
//  RecipeInfoResponseEntity.swift
//  RecetApp
//
//  Created by MacBook  on 26/01/23.
//

import Foundation
import CoreData

struct RecipeInfoNutritionResponseEntity: Decodable {
    
    let calories: Int?
    
    let sugar: Int?

    let carbohydrates: Int?
    
    let fiber: Int?
    
    let protein: Int?
    
    let fat: Int?
    
}

struct RecipeInfoSectionComponentResponseEntity: Decodable {
    
    let raw_text: String?
    
}

struct RecipeInfoSectionResponseEntity: Decodable {
    
    let components: [RecipeInfoSectionComponentResponseEntity]
    
}

struct RecipeInfoInstructionResponseEntity: Decodable {
    
    let display_text: String?
    
}

struct RecipeInfoResponseEntity: Decodable {
    
    let id: Int?
    
    let country: String?
    
    let language: String?
    
    let name: String?
    
    let description: String?
    
    let num_servings: Int?
    
    let total_time_minutes: Int?
    
    let prep_time_minutes: Int?
    
    let cook_time_minutes: Int?
    
    let thumbnail_url: String?
    
    let video_url: String?
    
    let original_video_url: String?
    
    let nutrition: RecipeInfoNutritionResponseEntity?
    
    let sections: [RecipeInfoSectionResponseEntity]?
    
    let instructions: [RecipeInfoInstructionResponseEntity]?
    
    var localRecipe: LocalRecipeInfoEntity {
        
        let id: Int = self.id ?? 0
        
        let country: String = self.country ?? "N/A"
        
        let language: String = self.language ?? "N/A"
        
        let name: String = self.name ?? "N/A"
        
        let description: String = self.description ?? "N/A"
        
        let numServings: Int = self.num_servings ?? 0
        
        let totalTimeMinutes: Int = self.total_time_minutes ?? 0
        
        let prepTimeMinutes: Int = self.prep_time_minutes ?? 0
        
        let cookTimeMinutes: Int = self.cook_time_minutes ?? 0
        
        let pictureUrl: String = self.thumbnail_url ?? "N/A"
        
        let videoUrl: String = self.original_video_url ?? "N/A"
        
        let calories: Int = self.nutrition?.calories ?? 0
        
        let sugar: Int = self.nutrition?.sugar ?? 0
        
        let carbohydrates: Int = self.nutrition?.carbohydrates ?? 0
        
        let fiber: Int = self.nutrition?.fiber ?? 0
        
        let protein: Int = self.nutrition?.protein ?? 0
        
        let fat: Int = self.nutrition?.fat ?? 0
        
        let ingredients: [String] = self.sections?.flatMap({ $0.components.map({ $0.raw_text ?? "N/A" }) }) ?? []
        
        /*for section in self.sections {
            ingredients.append(contentsOf: section.components.map({ $0.raw_text ?? "N/A" }))
        }*/
        
        let instructions: [String] = self.instructions?.map({ $0.display_text ?? "N/A" }) ?? []
        
        return LocalRecipeInfoEntity(id: id, country: country, language: language, name: name, description: description, numServings: numServings, totalTimeMinutes: totalTimeMinutes, prepTimeMinutes: prepTimeMinutes, cookTimeMinutes: cookTimeMinutes, pictureUrl: pictureUrl, videoUrl: videoUrl, calories: calories, sugar: sugar, carbohydrates: carbohydrates, fiber: fiber, protein: protein, fat: fat, ingredients: ingredients, instructions: instructions)
        
    }
    
}

struct LocalRecipeInfoEntity {
    
    let id: Int
    
    let country: String
    
    let language: String
    
    let name: String
    
    let description: String
    
    let numServings: Int
    
    let totalTimeMinutes: Int
    
    let prepTimeMinutes: Int
    
    let cookTimeMinutes: Int
    
    let pictureUrl: String
    
    let videoUrl: String
    
    let calories: Int
    
    let sugar: Int
    
    let carbohydrates: Int
    
    let fiber: Int
    
    let protein: Int
    
    let fat: Int
    
    let ingredients: [String]
    
    let instructions: [String]
    
    var isFavorite: Bool = false
    
    func makeFavorite(context: NSManagedObjectContext) -> LocalRecipeInfoEntity {
        
        var copy = self
        
        copy.isFavorite = false
        
        if let _ = try? context.fetch(RecipeInfoEntity.fetchRequest()).filter({ $0.id == Int32(self.id) }).first {
            
            print("La receta ya está en favoritos")
            
            copy.isFavorite = true
            
        } else {
            
            let recipe = RecipeInfoEntity(context: context)
            
            recipe.id = Int32(self.id)
            recipe.country = self.country
            recipe.language = self.language
            recipe.name = self.name
            recipe.details = self.description
            recipe.numServings = Int32(self.numServings)
            recipe.totalTimeMinutes = Int32(self.totalTimeMinutes)
            recipe.prepTimeMinutes = Int32(self.prepTimeMinutes)
            recipe.cookTimeMinutes = Int32(self.cookTimeMinutes)
            recipe.pictureUrl = self.pictureUrl
            recipe.videoUrl = self.videoUrl
            recipe.calories = Int32(self.calories)
            recipe.sugar = Int32(self.sugar)
            recipe.carbohydrates = Int32(self.carbohydrates)
            recipe.fiber = Int32(self.fiber)
            recipe.protein = Int32(self.protein)
            recipe.fat = Int32(self.fat)
            
            for label in self.ingredients {
                
                let ingredient = RecipeInfoIngredientEntity(context: context)
                
                ingredient.label = label
                
            }
            
            for label in self.instructions {
                
                let instruction = RecipeInfoInstructionEntity(context: context)
                
                instruction.label = label
                
            }
            
            do {
                
                try context.save()
                
                copy.isFavorite = true
                
            } catch {
                
                context.rollback()
                
            }
            
        }

        return copy
        
    }
    
    func unmakeFavorite(context: NSManagedObjectContext) -> LocalRecipeInfoEntity {
        
        var copy = self
        
        copy.isFavorite = true
        
        if let recipe = try? context.fetch(RecipeInfoEntity.fetchRequest()).filter({ $0.id == Int32(self.id) }).first {
            
            print("La receta si está en favoritos")
            
            context.delete(recipe)
            
            do {
                
                try context.save()
                
                copy.isFavorite = false
                
            } catch {
                
                context.rollback()
                
            }
            
        } else {
            
            copy.isFavorite = false
            
        }

        return copy
        
    }
    
}
