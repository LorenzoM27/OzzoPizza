//
//  OrderDto.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 06/09/2023.
//

import Foundation

struct OrderDto: Codable {
    
    let records : [RecordDto]
    
    struct RecordDto : Codable {
        
        let id: String
        let createdTime: String
        let fields : FieldDto
    }
    
    struct FieldDto : Codable {
        
        let quantity : Double
        let pizzaName: String
        let totalOrderPrice : Double
        let price: Double
        let customerName : String
        let indications : String
        
    }
    
}
