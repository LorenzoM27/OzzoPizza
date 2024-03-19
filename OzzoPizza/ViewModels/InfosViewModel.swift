//
//  InfosViewModel.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 03/08/2023.
//

import Foundation

class InfosViewModel : ObservableObject {
    
    @Published var infos = [Infos]()
    
    init() {
        fetchInfos()
    }
    
    
    func fetchInfos() {
        
        guard let url = URL(string: "https://api.airtable.com/v0/appHeqZIeYN0k7qux/Infos?maxRecords=3&view=Grid%20view")  else { return }
        
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
                    let response: InfosDto = try JSONDecoder().decode(InfosDto.self, from: data)
                    DispatchQueue.main.sync{
                        self.infos = []
                    }
                    for record in response.records {
                        DispatchQueue.main.sync {
                            self.infos.append(Infos(id: record.id, tel: record.fields.tel, tel2: record.fields.tel2, address: record.fields.address, image: record.fields.image))
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
