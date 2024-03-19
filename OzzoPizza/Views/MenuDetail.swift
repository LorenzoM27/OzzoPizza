//
//  MenuDetail.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 04/09/2023.
//

import SwiftUI

struct MenuDetail: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var delete = DeleteViewModel()
    @ObservedObject var edit = EditPizzaViewModel()
    
    let bases = ["tomate", "crème fraiche", "truffe"]
    
    var id : String
    var image : [ResponseDto.ImageDto]
    var pizzaName : String
    var price : Double
    var base : String
    var ingredients : String
    
    @State var imageID : String = ""
  
    //@State var newImage = // on verra
    @State var newName = ""
    @State var newPrice = ""
    @State var newBase = "tomate"
    @State var newIngredient = ""
    
    var body: some View {
        VStack{
            
            Text("Modifier la pizza \(pizzaName)")
                .font(.title)
            
            ForEach(image) { image in
                AsyncImage(url: URL(string: image.url)) { image in
                    image
                        .resizable()
                        .cornerRadius(15)
                        .frame(width: 350, height: 300)
                    
                } placeholder: {
                    ProgressView()
                }
                
            }
            
            TextField(pizzaName, text: $newName)
                .padding()
                .frame(width: 300, height: 50)
                .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                .cornerRadius(10)
            
            TextField(ingredients, text: $newIngredient)
                .padding()
                .frame(width: 300, height: 50)
                .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                .cornerRadius(10)
            
            HStack {
                Text("Base actuelle : \(base)")
                Picker("Sélectionner la base :", selection: $newBase) {
                    ForEach(bases, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            TextField("\(String(format: "%.2f", price))", text: $newPrice)
                .padding()
                .frame(width: 300, height: 50)
                .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                .cornerRadius(10)
            
            Button {
                for image in image {
                     imageID = image.id
                }
                edit.editPizza(id: id, newBase: newBase, newName: newName, newIngredients: newIngredient, newPrice: newPrice, imageID: imageID)
            } label: {
                Text("Modifier la pizza")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(width: 300, height: 50)
                    .background(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10)
            }
            
            Button {
                delete.deletePizza(id: id, deleted: true)
            } label: {
                Text("Supprimer la pizza")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(.red)
                    .cornerRadius(10)
            }

        }
        
       
    }
}

//struct MenuDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuDetail()
//    }
//}
