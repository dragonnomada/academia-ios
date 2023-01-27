//
//  EdemamApiService.swift
//  MyDailyDiet
//
//  Created by MacBook on 23/01/23.
//
// RecipeInfoEntity
// RecipeApiEntity

import Foundation
import Combine
import CoreData

//Enumerable para el manejo de errores
enum ApiServiceErrors: Error {
    
    case invalidRecipe
}

class EdamamService {
    
    //Creación del contenedor para cargar los datos persistentes
    lazy var containerUserInfo: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyDailyDiet")
        
        container.loadPersistentStores {
            
            _, error in
            
            if let error = error {
                
                fatalError("Error al cargar el contenedor del CoreData: \(error)")
                
            }
            
        }
        
        return container
        
    }()
    
    // State
    var recetas: [RecipeDetails] = []
    
    // Notificators
    
    // Notifica que las recetas han sido cargadas desde la api
    var recipesFetchedSubject = PassthroughSubject<[RecipeDetails], Never>()
    // Receta seleccionada
    let recipeSelected = PassthroughSubject<(RecipeDetails?, ApiServiceErrors?), Never>()
    // Notifica que una receta ha sido seleccionada
    let recipeModified = PassthroughSubject<(RecipeDetails?, ApiServiceErrors?), Never>()
    
    // Transactions
    
    // Descragar las recetas desde la url de la api
    func fetchRecipes() {
        
        guard let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=pollo&app_id=f96df2b8&app_key=0f6b3a0641795cfa4289ba79dbb98572") else { return }

        print("Solicitando API")
        
        let session = URLSession.shared.dataTask(with: url) { [self]
            (data, response, error) in
            
            print("El API ha respondido")
            
            if let error = error {
                print("Error al consumir el api \(url). Error: \(error)")
                return
            }
            
            print("1")
            if let data = data {
                if let text = String(data: data, encoding: .utf8) {
                    print("EL texto es: \(text)")
                }
                print("2")
                /*if let recipe = try? JSONDecoder().decode(Recipes.self, from: data) {
                    print("Las recetas son: \(recipe)")
                    self.recetas = recipe.hits
                }*/
                
                do {
                    
                    let recipe = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    
                    print("Las recetas son: \(recipe)")
                    
                    self.recetas = recipe.hits.map({ $0.recipe })
                    
                } catch {
                    
                    print("Error en el JSON: \(error)")
                    
                }
            }
        }// Termina clousure
        print("Enviando la petición a la sesión del API")
        session.resume()
        
    }
    
    func saveRecipe(nameRecipe: String, id: String) {
        
        recetas.map {
            [weak self] recipes in
            
            //nameRecipe = recipes.label
        }
    }
    
}

