//
//  EdemamApiService.swift
//  MyDailyDiet
//
//  Created by MacBook on 23/01/23.
//

import Foundation
import Combine

class EdamamService {
    
    // State
    var recetas: [Recipes] = []
    private var recipeSelected: Recipes?
    
    // Notificators
    var recipesFetchedSubject = PassthroughSubject<[Recipes], Never>()
    
    // receta seleccionada
    var recipesSelectedSubject = PassthroughSubject<Recipes, Never>()
    
    
    // Transactions
    
    // Descragar las recetas desde la url de la api
    func downloadRecipes() async {
        guard let url = URL(string: "https://api.edamam.com/api/food-database/v2/parser?app_id=7a59f6ec&app_key=929da941a4e040cb33b5ec7539e78893&ingr=pollo&nutrition-type=cooking") else {
            
            // TODO: Notificar que la URL no es válida
            
            return
        }

        print("Solicitando API")
        
        let session = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            // TODO: Notificar que hubo error en la petición
            
            print("El API ha respondido")
            
            if let error = error {
                print("Error al consumir el api \(url). Error: \(error)")
                return
            }
            
            if let data = data {
                if let text = String(data: data, encoding: .utf8) {
                    print("La respuesta es: \(text)")
                }
                if let recipeResponse = try? JSONDecoder().decode(RecipeResponse.self, from: data) {
                    print(recipeResponse)
                    self.recetas = recipeResponse.hints
                    // TODO: Notifica que las canciones fueron descargadas
                    self.recipesFetchedSubject.send(self.recetas)
                }
            }
        }
        print("Enviando la petición a la sesión del API")
        session.resume()
        
        /*
        print("Download recipes from API")
        
        guard let url = URL(string: "http://34.125.242.89/api/musicapp/songs") else {
            
            // TODO: Notificar que la URL no es válida
            
            return
            
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            
            // TODO: Notificar que hubo error en la petición
            
            return
            
        }
        
        guard let recipesResponse = try? JSONDecoder().decode(RecipesResponseEntity.self, from: data) else {
            
            // TODO: Notificar que hubo un error al decodificar las recetas
            
            return
            
        }
        
        // TODO: Notificar que las recetas fueron descargadas
        recipesFetchedSubject.send(self.recipes)
         */
        
    }
    
    // Seleccionar una receta
    
    func recipeSelect() {
    }
    
    // Guardar la receta seleccionada
    
}
