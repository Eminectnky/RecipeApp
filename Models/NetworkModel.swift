//
//  NetworkModel.swift
//  RecipeApp
//
//  Created by Emine CETINKAYA on 2.09.2023.
//

import Foundation

@MainActor
class NetworkModel: ObservableObject{
    
    @Published var recipes: [Recipe] = []
    
    func fetchRecipes() async throws{
        
        var request = URLRequest(url: URL(string: "https://food2fork.ca/api/recipe/search/?page=2&query=beef")!)
        request.addValue("Token 9c8b06d329136da358c2d00e76946b0111ce2c48", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        let recipeResponse =  try JSONDecoder().decode(RecipeResponse.self, from: data)
        recipes = recipeResponse.results
    }
}
