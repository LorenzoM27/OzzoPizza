//
//  Infos.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 03/08/2023.
//

import Foundation

struct Infos: Codable, Identifiable {
    
    var id : String
    let tel: String
    let tel2: String
    let address: String
    let image: [InfosDto.ImageDto]
    
}
