//
//  AddPizzaView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 04/09/2023.
//

import SwiftUI

struct AddPizzaView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @ObservedObject var pizzaMenu = AddPizzaMenuViewModel()
    
    let bases = ["tomate", "crème fraiche", "truffe"]
    
    @State var isPickerShowing = false
    @State var selectedImage : UIImage?
    @State var imageURL : URL
    
    @State var pizzaName = ""
    @State var ingredients = ""
    @State var base = ""
    @State var price = ""
    
    var body: some View {
        
        VStack {
            HStack{
                Button {
                    dismiss()
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Text("Retour")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }

                Spacer()
            }
            .padding()
            Text("Ajouter une pizza")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.bottom)
            
            
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
            Button {
                isPickerShowing = true
            } label: {
                Text("Choisir une image")
                    .foregroundColor(.blue)
            }
            .padding()
            
            
            TextField("Nom de la pizza", text: $pizzaName)
                .padding()
                .frame(width: 300, height: 50)
                .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                .cornerRadius(10)
            
            TextField("Ingrédients", text: $ingredients, axis: .vertical)
                .lineLimit(4, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
                .padding()
                //.frame(width: 300, height: 50)
                //.background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                //.cornerRadius(10)
            
            
            TextField("Prix : \(String(format: "%.2f", price))", text: $price)
                .padding()
                .frame(width: 300, height: 50)
                .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                .cornerRadius(10)
            
//            TextField("Base de la pizza", text: $base)
//                .padding()
//                .frame(width: 300, height: 50)
//                .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
//                .cornerRadius(10)
            
            HStack {
                Text("Base de la pizza :")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                Picker("Sélectionner la base :", selection: $base) {
                    ForEach(bases, id: \.self) {
                        Text($0)
                    }
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
            Spacer()
            
            Button {
                print(imageURL)
                pizzaPost()
                
            } label: {
                Text("Ajouter la pizza au menu")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(width: 300, height: 50)
                    .background(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            
           
        }
        .sheet(isPresented: $isPickerShowing) {
            // image picker view
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, imageUrl: $imageURL)
        }
        
    }
    
    
    
    func pizzaPost() {
            
        let newPizza = PizzaMenu(pizzaName: pizzaName, ingredients: ingredients, price: Double(price)!, image: ["\(PizzaMenu.imageURL(url: "\(imageURL)"))"], base: base.lowercased())
        pizzaMenu.pizza = newPizza
            
        pizzaMenu.postPizza()
            
    }
}

struct AddPizzaView_Previews: PreviewProvider {
    static var previews: some View {
        AddPizzaView( imageURL: URL(string: "v")!)
    }
}
