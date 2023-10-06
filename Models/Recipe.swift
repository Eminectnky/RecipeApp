//
//  Recipe.swift
//  RecipeApp
//
//  Created by Emine CETINKAYA on 2.09.2023.
//

import Foundation

struct RecipeResponse: Decodable{
    let results: [Recipe]
}


struct Recipe: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let featuredImage: URL
    
    private enum CodingKeys: String, CodingKey{
        
        case id = "pk"
        case title = "title"
        case featuredImage = "featured_image"
    }
}
