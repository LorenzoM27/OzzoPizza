//
//  OrderListViewModel.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 06/09/2023.
//

import Foundation

class OrderListViewModel : ObservableObject {
    
    @Published var orderList = [Order]()
    
    init() {
        fetchOrderList()
    }
    
    func fetchOrderList()  {
        
        guard let url = URL(string: "https://api.airtable.com/v0/appHeqZIeYN0k7qux/Orders?maxRecords=30&view=Grid%20view")  else { return }
        
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
                    let response: OrderDto = try JSONDecoder().decode(OrderDto.self, from: data)
                    DispatchQueue.main.sync{
                        self.orderList = []
                    }
                    for record in response.records {
                        DispatchQueue.main.sync {
                            self.orderList.append(Order(id: record.id, customerName: record.fields.customerName, pizzaName: record.fields.pizzaName, quantity: record.fields.quantity, price: record.fields.price, totalPrice: record.fields.totalOrderPrice, indications: record.fields.indications))
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
