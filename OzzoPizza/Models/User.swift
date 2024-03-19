//
//  User.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 01/08/2023.
//

import Foundation


struct User: Codable, Identifiable {
    
    var id : String
    var mail : String
    var password : String
    var type : String
    
}
