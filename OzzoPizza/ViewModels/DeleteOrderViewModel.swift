//
//  DeleteOrderViewModel.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 06/09/2023.
//

import Foundation

class DeleteOrderViewModel : ObservableObject {
    
    
    func deleteOrder(id : String, deleted : Bool) {
                
        let json : [String: Any] = ["id" : id , "deleted" : deleted]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard let url = URL(string: "https://api.airtable.com/v0/appHeqZIeYN0k7qux/Orders/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer pat34IoFFWwLXWE2R.09ad8ba3eb44ec12e2636ddc8bd9af62c21a9a2fbce16bdef8b22d73b29bffd2", forHTTPHeaderField: "Authorization")
         
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Impossible to delete")
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
