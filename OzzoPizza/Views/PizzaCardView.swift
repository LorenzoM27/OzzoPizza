//
//  PizzaCardView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 29/04/2023.
//

import SwiftUI

struct PizzaCardView: View {
    
    var image: [ResponseDto.ImageDto]
    var pizzaName: String
    var price: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(image) { image in
                AsyncImage(url: URL(string: image.url)) { image in
                    image
                        .resizable()
                        .frame(width: 175, height: 175)
                    
                } placeholder: {
                    ProgressView()
                }
            }
            VStack(alignment: .center){
                HStack {
                    Spacer()
                    Text(pizzaName)
                        .foregroundColor(.gray)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\(String(format: "%.2f", price)) €")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.bottom, 16)
                    Spacer()
                }
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 8)
        .padding()
        
    }
}

//struct PizzaCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PizzaCardView( image: [ResponseDto.ImageDto(id: "123", width: 200, height: 200, url: "logo", filename: "test", size: 20, type: "image", thumbnails:
//                                                        ResponseDto.ThumbnailDto(
//                                                            small: ResponseDto.imageSizeDto(url: "test", width: 200, height: 200),
//                                                            large: ResponseDto.imageSizeDto(url: "test", width: 200, height: 200),
//                                                            full: ResponseDto.imageSizeDto(url: "test", width: 200, height: 200)],
//                       pizzaName: "Pizza Ozzo", price: 10)
//    }
//}
