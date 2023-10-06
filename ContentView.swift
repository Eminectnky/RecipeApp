//
//  ContentView.swift
//  RecipeApp
//
//  Created by Emine CETINKAYA on 2.09.2023.
//

import SwiftUI

enum SortDirection{
    case asc
    case desc
}

struct ContentView: View {
    
    @State private var search: String = ""
    @State private var filteredRecipes: [Recipe] = []
    @StateObject private var networkModel = NetworkModel()
    @State private var sortDirection: SortDirection = .asc
 
  //deneme
    
    private func performSearch(keyword: String){
        filteredRecipes = networkModel.recipes.filter { recipe in
            recipe.title.contains(keyword)
        }
    }
        
    private var recipes: [Recipe]{
        filteredRecipes.isEmpty ? networkModel.recipes: filteredRecipes
    }
    
    
    var sortDirectionText: String {
        sortDirection == .asc ? "Sort Descending" : "Sort Ascending"
    }
    
    private func performSort(sortDirection: SortDirection){
        
        var sortedRecipes = recipes
        
        switch sortDirection{
            
        case.asc:
            sortedRecipes.sort { lhs, rhs in
                lhs.title < rhs.title
                
            }
        case.desc:
            sortedRecipes.sort { lhs, rhs in
                lhs.title > rhs.title
                
            }
        }
        
        if filteredRecipes.isEmpty{
            networkModel.recipes = sortedRecipes
        }else{
            
            filteredRecipes = sortedRecipes
        }
    }
    
    
    var body: some View {
        
   
        
        
        NavigationStack {
            
            VStack{
                
                Button(sortDirectionText){
                    sortDirection = sortDirection == .asc ? .desc: .asc
                }
                
                List(recipes){ recipe in
                    
                    HStack {
                        AsyncImage(url: recipe.featuredImage){ image in
                            image
                                
                                .resizable()
                                .scaledToFill()
//                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .clipped()
                            
                        }placeholder: {
//                           Text("Loading...")
                            
                            ProgressView()
                                .padding()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(2.0)
                            
                         
                            
                        }
                        Text(recipe.title)
                        
                    }
                    
                }
                .searchable(text: $search)
                .onChange(of: search, perform: performSearch)
                .onChange(of: sortDirection, perform: performSort)
                .task{
                    do{
                      try  await networkModel.fetchRecipes()
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
 
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
    }
}
