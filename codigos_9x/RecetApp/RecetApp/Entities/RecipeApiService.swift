//
//  RecipeApiService.swift
//  RecetApp
//
//  Created by MacBook  on 26/01/23.
//

import Foundation

class RecipeApiService {
    
    var recipesSearched: [LocalRecipeInfoEntity] = []
    
    func search(query text: String) {
        
        let headers = [
            "X-RapidAPI-Key": "95d1af3cbfmshdd155205f6b9189p12f614jsn43739ff11b8e",
            "X-RapidAPI-Host": "tasty.p.rapidapi.com"
        ]

        guard let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            
            return
            
        }
        
        guard let url = NSURL(string: "https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=under_30_minutes&q=\(query)") as? URL else {
            
            return
            
        }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                
                print("Error while search recipes: \(error)")
                
                return
                
            }
            
            if let data = data {
                
                do {
                    
                    let result = try JSONDecoder().decode(RecipeListResponseEntity .self, from: data)
                    
                    print("Result: \(result)")
                    
                } catch {
                    
                    print("JSON Error: \(error)")
                    
                }
                
            }
            
        })

        dataTask.resume()
        
    }
    
}
