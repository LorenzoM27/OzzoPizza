//
//  SectionView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 12/03/2024.
//

import SwiftUI

struct SectionView: View {
    
    @ObservedObject var pizzaModel = PizzaViewModel()
    
    var section : String
    var base : String
    
    var body: some View {
        Section(section) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(pizzaModel.pizza) { pizza in
                        if pizza.base == base {
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
}

#Preview {
    NavigationStack {
        SectionView( section: "Test", base: "tomate")
    }
}
