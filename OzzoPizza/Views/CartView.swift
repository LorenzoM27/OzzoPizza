//
//  CartView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 30/04/2023.
//

import SwiftUI

struct CartView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.price, order: .reverse)]) var pizza: FetchedResults<Cart>
    var orderModel = OrderViewModel()
    @State private var customer = ""
    @State private var showingAlert = false
    @State private var isOrderSend = false
    
    
    var body: some View {
        
        VStack{
            HStack {
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
                
                Text("Mon Panier")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Spacer()
            }
            .padding()
            
            List {
                ForEach(pizza) { pizza in
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text("Pizza " + (pizza.pizzaName ?? "erreur"))
                            
                            if pizza.personalization != "indications" {
                                
                                Text("Sans \(pizza.personalization ?? "indications")")
                                    .font(.footnote)
                                    .lineLimit(1)
                            }
                            
                            Text("\(String(format: "%.2f", pizza.price)) €")
                                .fontWeight(.bold)
                                .padding(.top, 10)
                        }
                        Spacer()
                        VStack{
                            
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .frame(width: 35, height: 35)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                                .shadow(radius: 3)
                                .onTapGesture {
                                    DataController().addQuantity(cart: pizza, quantity: pizza.quantity, personalization: pizza.personalization!, context: managedObjectContext)
                                }
                            
                            Text("\(String(format: "%.0f", pizza.quantity))")
                                .foregroundColor(.white)
                                .frame(width: 35, height: 35)
                                .background(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                                .shadow(color: colorScheme == .dark ? .gray : .black, radius: 3)
                            
                            Image(systemName: "minus")
                                .foregroundColor(.black)
                                .frame(width: 35, height: 35)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                                .shadow(radius: 3)
                                .onTapGesture {
                                    DataController().removeQuantity(cart: pizza, quantity: pizza.quantity, personalization: pizza.personalization!, context: managedObjectContext)
                                }
                        }
                    }
                    .padding()
                    //.frame(width: 400, height: 100)
                    .background(colorScheme == .dark ? .black.opacity(0.0) : .white)
                    .cornerRadius(10)
                }
                
            }.listStyle(.plain)
            
            TextField("Votre nom", text: $customer)
                .padding()
            HStack {
                Text("Total : ")
                Spacer()
                Text("\(String(format: "%.2f", total())) €")
                    .fontWeight(.bold)
            }
            .padding(20)
            
            Button {
                if customer.isEmpty && !pizza.isEmpty {
                    showingAlert = true
                } else if !customer.isEmpty && !pizza.isEmpty {
                    orderPost()
                    //dismiss()
                    customer = ""
                    isOrderSend.toggle()
                } else {
                    print("Empty")
                }
            } label: {
                Text("Commander")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(width: 300, height: 50)
                    .background(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10)
            }
            .alert("Insérez votre nom pour la commande", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            .alert("Votre commande est envoyée !", isPresented: $isOrderSend) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    func total() -> Double {
        
        var totalToPay: Double = 0
        
        for item in pizza {
            totalToPay += item.totalPrice
        }
        return totalToPay
    }
    
    func orderPost() {
        
        for item in pizza {
            
            let order = Order(id: "", customerName: customer, pizzaName: item.pizzaName!, quantity: item.quantity, price: item.price, totalPrice: item.totalPrice, indications: item.personalization!)
            orderModel.order = order
            
            orderModel.postOrder()
            DataController().removeOrder(cart: item, context: managedObjectContext)
            
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
