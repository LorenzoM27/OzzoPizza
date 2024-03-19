//
//  PizzaDetailView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 30/04/2023.
//

import SwiftUI

struct PizzaDetailView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.colorScheme) var colorScheme
    
    var image: [ResponseDto.ImageDto]
    var pizzaName: String
    var price: Double
    var ingredients: String
    @State var quantity: Double = 1
    
    @State var isPersonalize = false
    @State var personalize = ""
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack{
                    Text("Pizza \(pizzaName)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
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
                    
                    Text("\(String(format: "%.2f", price)) €")
                        .font(.title2)
                        .fontWeight(.bold)
                        .font(.system(size: 35))
                        .padding(.bottom)
                    HStack{
                        Button {
                            if quantity > 1 {
                                quantity -= 1
                            }
                        } label: {
                            Image(systemName: "minus")
                                .foregroundColor(.black)
                                .frame(width: 35, height: 35)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                                .shadow(radius: 3)
                        }
                        Text("\(String(format: "%.0f", quantity))")
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .shadow(color: colorScheme == .dark ? .gray : .black, radius: 3)
                        Button {
                            quantity += 1
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .frame(width: 35, height: 35)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                                .shadow(radius: 3)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    Text("Ingrédients :")
                        .multilineTextAlignment(.leading)
                        .fontWeight(.semibold)
                    
                    Text(ingredients)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.top, 10)
                }
            }
            .sheet(isPresented: $isPersonalize) {
                PersonalizeView(personalize: $personalize)
            }
            
            VStack{
                Spacer()
                
                Button {
                    isPersonalize.toggle()
                } label: {
                    Text("Personnaliser")
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .frame(width: 300, height: 50)
                        .background(colorScheme == .dark ? .white : .gray)
                        .cornerRadius(10)
                }
                
                Button {
                    if personalize == "" {
                        personalize = "indications"
                    }
                    DataController().addPizza(name: pizzaName, price: price, quantity: quantity, personalization: personalize, context: managedObjectContext)
                } label: {
                    Text("Ajouter au panier")
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .frame(width: 300, height: 50)
                        .background(colorScheme == .dark ? .white : .black)
                        .cornerRadius(10)
                }
            }
        }
    }
}

//struct PizzaDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PizzaDetailView()
//    }
//}
