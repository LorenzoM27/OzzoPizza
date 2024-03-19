//
//  UserDto.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 01/08/2023.
//

import Foundation


struct UserDto: Codable {
    
    let records : [RecordDto]
    
    struct RecordDto : Codable {

        let id: String
        let createdTime: String
        let fields : FieldDto
    }
    
    struct FieldDto : Codable {
        
        let mail : String
        let password : String
        let type : String
    }
    
}
