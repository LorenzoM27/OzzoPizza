//
//  MenuItem.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 04/09/2023.
//

import SwiftUI

struct MenuItem: View {
    
    @ObservedObject var delete = DeleteViewModel()
    
    var image : [ResponseDto.ImageDto]
    var pizzaName : String
    var price : Double
    var id : String
    
    var body: some View {
        HStack {
            ForEach(image) { image in
                AsyncImage(url: URL(string: image.url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(25)
                        .frame(width: 50, height: 50)
                    
                } placeholder: {
                    ProgressView()
                }
                
                Text(pizzaName)
                
                Spacer()
                
                Text("\(String(format: "%.2f", price)) €")
                
                
            }
            
        }
        .swipeActions {
            Button {
                withAnimation {
                    delete.deletePizza(id: id, deleted: true)
                }
                
            } label: {
                Image(systemName: "trash.fill")
            }
            .tint(.red)
        }
        .padding()
        
    }
}

//struct MenuItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItem()
//    }
//}
