//
//  OrderItem.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 06/09/2023.
//

import SwiftUI

struct OrderItem: View {
    
    var id : String
    var customerName : String
    var pizzaName : String
    var quantity : Double
    var price : Double
    var totalPrice : Double
    var indications : String
    
    @State var isTruncated: Bool = false
    
    var body: some View {
        
        
        HStack {
            Text(customerName)
            Spacer()
            Text(pizzaName)
            Spacer()
            VStack {
                Text("Sans \(indications)")
                    .lineLimit(1)
                .truncationMode(.tail)
                Button {
                    isTruncated.toggle()
                } label: {
                    Text("Voir les indications")
                        .foregroundColor(.blue)
                        .font(.footnote)
                }

            }
            .sheet(isPresented: $isTruncated) {
                Text("Sans \(indications)")
            }
            Spacer()
            Text("\(String(format: "%.0f", quantity))")
            Spacer()
           // Text("\(String(format: "%.2f", price)) €")
           // Spacer()
            Text("\(String(format: "%.2f", totalPrice)) €")
        }

    }
}

//struct OrderItem_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderItem()
//    }
//}
