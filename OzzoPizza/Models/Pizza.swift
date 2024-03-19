//
//  Pizza.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 29/04/2023.
//

import Foundation

struct Pizza: Identifiable, Codable {
    
    let id: String
    let pizzaName: String
    let ingredients: String
    let price: Double
    let base: String
    let image: [ResponseDto.ImageDto]
    
}
