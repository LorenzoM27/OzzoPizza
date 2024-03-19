//
//  PizzaMenu.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 14/09/2023.
//

import Foundation

struct PizzaMenu: Codable {
    
    var pizzaName : String
    var ingredients : String
    var price : Double
    //var image : [imageURL]
    var image : [String]
    var base : String
    
    struct imageURL: Codable {

        var url : String
    }
    
}
