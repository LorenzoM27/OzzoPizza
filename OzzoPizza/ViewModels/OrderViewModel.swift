//
//  OrderViewModel.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 01/05/2023.
//

import Foundation

class OrderViewModel  {
    
    //@Published var order = [Order]()
    var order = Order(id: "", customerName: "", pizzaName: "", quantity: 1, price: 0, totalPrice: 0, indications: "")
    
    func postOrder() {
        
        let json : [String: Any] = ["fields" : ["customerName": order.customerName, "pizzaName" : order.pizzaName, "quantity": order.quantity, "price": order.price, "totalOrderPrice": order.totalPrice, "indications": order.indications] as [String : Any]]
        
        
        //        var fields = ["fields" : ["customerName": order.customerName, "pizzaName" : order.pizzaName, "quantity": order.quantity, "price": order.price, "totalPrice": order.totalPrice] as [String : Any]]
        //
        //        var json = ["Records" : fields]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard let url = URL(string: "https://api.airtable.com/v0/appHeqZIeYN0k7qux/Orders") else { return }
        
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
