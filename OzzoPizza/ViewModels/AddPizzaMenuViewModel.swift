//
//  AddPizzaMenu.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 14/09/2023.
//

import Foundation


class AddPizzaMenuViewModel : ObservableObject {
   
    @Published var pizza = PizzaMenu(pizzaName: "", ingredients: "", price: 0.0, image: [], base: "")
   
    func postPizza() {
        
        let json : [String: Any] = ["fields" : ["pizzaName": pizza.pizzaName, "ingredients" : pizza.ingredients, "price": pizza.price, "image": pizza.image, "base": pizza.base] as [String : Any]]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard let url = URL(string: "https://api.airtable.com/v0/appHeqZIeYN0k7qux/Menu") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer pat34IoFFWwLXWE2R.09ad8ba3eb44ec12e2636ddc8bd9af62c21a9a2fbce16bdef8b22d73b29bffd2", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
         
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No Data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
}
