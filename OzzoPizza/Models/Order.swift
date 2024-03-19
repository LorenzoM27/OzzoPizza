//
//  Order.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 01/05/2023.
//

import Foundation

struct Order: Codable, Hashable, Identifiable {
    
    var id : String
    var customerName : String
    var pizzaName : String
    var quantity : Double
    var price : Double
    var totalPrice : Double
    var indications : String
    
}
