//
//  RecipeListResponseEntity.swift
//  RecetApp
//
//  Created by MacBook  on 26/01/23.
//

import Foundation

struct RecipeListResponseEntity: Decodable {
    
    let count: Int
    
    let results: [RecipeInfoResponseEntity]
    
    func getLocalRecipes() -> [LocalRecipeInfoEntity] {
        
        return self.results.map({ $0.localRecipe })
        
    }
    
}
