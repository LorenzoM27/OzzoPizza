//
//  ContentView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 29/04/2023.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @ObservedObject var pizzaModel = PizzaViewModel()
    @ObservedObject var infosModel = InfosViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack{
                        SectionView(section: "Bases Tomates", base: "tomate")
//                        SectionView(section: "Bases crème fraiche", base: "crème fraiche")
//                        SectionView(section: "Bases truffe", base: "truffe")
                               
//                        Section("Bases Tomates") {
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack {
//                                    ForEach(pizzaModel.pizza) { pizza in
//                                        if pizza.base == "tomate" {
//                                            NavigationLink {
//                                                PizzaDetailView(image: pizza.image, pizzaName: pizza.pizzaName, price: pizza.price, ingredients: pizza.ingredients)
//                                            } label: {
//                                                PizzaCardView(image: pizza.image, pizzaName: pizza.pizzaName, price: pizza.price)
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
                        Section("Bases crème fraiche") {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(pizzaModel.pizza) { pizza in
                                        if pizza.base == "crème fraiche" {
                                            NavigationLink {
                                                PizzaDetailView(image: pizza.image, pizzaName: pizza.pizzaName, price: pizza.price, ingredients: pizza.ingredients)
                                            } label: {
                                                PizzaCardView(image: pizza.image, pizzaName: pizza.pizzaName, price: pizza.price)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Section("Bases truffe") {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(pizzaModel.pizza) { pizza in
                                        if pizza.base == "truffe" {
                                            NavigationLink {
                                                PizzaDetailView(image: pizza.image, pizzaName: pizza.pizzaName, price: pizza.price, ingredients: pizza.ingredients)
                                            } label: {
                                                PizzaCardView(image: pizza.image, pizzaName: pizza.pizzaName, price: pizza.price)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onAppear {
                        permission()
                    }
                    .navigationTitle("Nos Pizzas")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink {
                                ForEach(infosModel.infos) { infos in
                                    InfosView(image: infos.image, tel: infos.tel, tel2: infos.tel2, address: infos.address)
                                }
                            } label: {
                                Image(systemName: "info.circle")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink {
                                Connection()
                            } label: {
                                Image(systemName: "person")
                            }
                        }
                    }
                }
                CartButtonView()
            }
            .refreshable {
                pizzaModel.fetchPizza()
                infosModel.fetchInfos()
            }
            
        }
    }
    
    func permission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("authorization notification")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
