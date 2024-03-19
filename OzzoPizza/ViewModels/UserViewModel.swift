//
//  UserViewModel.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 01/08/2023.
//

import Foundation

class UserViewModel : ObservableObject {
    
    @Published var user = [User]()
    
    func fetchUser() async {
        
        guard let url = URL(string: "https://api.airtable.com/v0/appHeqZIeYN0k7qux/users?maxRecords=10&view=Grid%20view")  else { return }
        
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
                    let response: UserDto = try JSONDecoder().decode(UserDto.self, from: data)
                    DispatchQueue.main.sync{
                        self.user = []
                    }
                    for record in response.records {
                        DispatchQueue.main.sync {
                            self.user.append(User(id: record.id, mail: record.fields.mail, password: record.fields.password, type: record.fields.type))
                        }
                    }
                } catch {
                    print("failed to fetch user data")
                }
            }
        }
        task.resume()
    }
}

