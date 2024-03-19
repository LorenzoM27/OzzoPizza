//
//  ResponseDto.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 29/04/2023.
//

import Foundation

struct ResponseDto: Codable {

    let records : [RecordDto]

    struct RecordDto : Codable {

        let id: String
        let createdTime: String
        let fields : FieldDto
    }

    struct FieldDto : Codable {

        let base: String
        let image: [ImageDto]
        let pizzaName: String
        let ingredients: String
        let price: Double

    }

    struct ImageDto: Codable, Identifiable {

        let id: String
        let width: Int
        let height: Int
        let url: String
        let filename: String
        let size: Int
        let type: String
        let thumbnails : ThumbnailDto
    }

    struct ThumbnailDto : Codable {

        let small: imageSizeDto
        let large: imageSizeDto
        let full: imageSizeDto

    }

    struct imageSizeDto : Codable {

        let url: String
        let width: Int
        let height: Int
    }
}
