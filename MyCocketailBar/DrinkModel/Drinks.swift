//
//  Drinks.swift
//  MyCocketailBar
//
//  Created by Elisangela Pethke on 06.06.24.
//

import Foundation

class Drinks {
    struct Returned: Codable {
        var drinks: [Drink]
    }
    
    let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=A"
    
    var drinkArray: [Drink] = []
    
    func getData(completed: @escaping () -> ()) {
        print("Estamos acessando a URL \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("ERRO: Não foi possível criar uma URL a partir de \(urlString)")
            completed()
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("ERRO: \(error.localizedDescription)")
                completed()
                return
            }
            
            do {
                guard let data = data else {
                    print("ERRO: Nenhum dado retornado")
                    completed()
                    return
                }
                
                let returned = try JSONDecoder().decode(Returned.self, from: data)
                self.drinkArray = self.drinkArray + returned.drinks
                
            } catch {
                print("ERRO: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}
