//
//  PizzaViewModels.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 29/04/2023.
//

import Foundation

class PizzaViewModel : ObservableObject {
    
    @Published var pizza = [Pizza]()
    
    init() {
        fetchPizza()
    }
    
    
    func fetchPizza() {
        
        guard let url = URL(string: "https://api.airtable.com/v0/appHeqZIeYN0k7qux/Menu?maxRecords=30&view=Grid%20view")  else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer pat34IoFFWwLXWE2R.09ad8ba3eb44ec12e2636ddc8bd9af62c21a9a2fbce16bdef8b22d73b29bffd2", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                do {
                    let response: ResponseDto = try JSONDecoder().decode(ResponseDto.self, from: data)
                    DispatchQueue.main.sync{
                        self.pizza = []
                    }
                    for record in response.records {
                        DispatchQueue.main.sync {
                            self.pizza.append(Pizza(id: record.id, pizzaName: record.fields.pizzaName, ingredients: record.fields.ingredients, price: record.fields.price, base: record.fields.base, image: record.fields.image))
                        }
                    }
                } catch {
                    print("failed to fetch data")
                }
            }
        }
        task.resume()
    }
}
