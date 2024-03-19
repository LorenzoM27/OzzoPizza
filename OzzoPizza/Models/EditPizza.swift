//
//  EditPizza.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 05/09/2023.
//

import Foundation



struct EditPizza: Codable {
    let fields: Fields
    
    struct Fields: Codable {
        let pizzaName, ingredients: String
        let price: Double
        let image: [Image]
        let base: String
    }

    struct Image: Codable {
        let id: String
    }
}


