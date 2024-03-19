//
//  MenuView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 04/09/2023.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var menu = PizzaViewModel()
    @ObservedObject var deleteOrder = DeleteOrderViewModel()
    
    @State var showingAddView = false
    @State var showingDetailView = false
    
    
    var body: some View {
        
        VStack{
            
            List {
                ForEach(menu.pizza) { pizza in
                    
                    NavigationLink {
                        MenuDetail(id: pizza.id, image: pizza.image, pizzaName: pizza.pizzaName, price: pizza.price, base: pizza.base, ingredients: pizza.ingredients)
                    } label: {
                        MenuItem(image: pizza.image, pizzaName: pizza.pizzaName, price: pizza.price, id: pizza.id)
                    }
                }
                .onDelete(perform: deleteOrderFunc)
            }
            .listStyle(.plain)
        }
        .navigationTitle("La carte")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    showingAddView.toggle()
                } label: {
                    Label("Ajouter plat", systemImage: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddPizzaView(imageURL: URL(string: "v")!)
        }
        .refreshable {
            menu.fetchPizza()
        }
        
    }
    
    private func deleteOrderFunc(indexSet: IndexSet) {
        
        let id = indexSet.map {menu.pizza[$0].id}
        DispatchQueue.main.async {
            self.deleteOrder.deleteOrder(id: id[0], deleted: true)
            menu.fetchPizza()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
