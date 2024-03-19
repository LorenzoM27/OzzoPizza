//
//  OrdersView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 06/09/2023.
//

import SwiftUI
import UserNotifications

struct OrdersView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var orderList = OrderListViewModel()
    @ObservedObject var deleteOrder = DeleteOrderViewModel()

    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Nom")
                    .fontWeight(.bold)
                Spacer()
                Text("Pizza")
                    .fontWeight(.bold)
                Spacer()
                Text("Indication")
                    .fontWeight(.bold)
                Spacer()
                Text("Quantité")
                    .fontWeight(.bold)
                Spacer()
//                Text("Prix")
//                    .fontWeight(.bold)
//                Spacer()
                Text("Prix total")
                    .fontWeight(.bold)
            }
            .padding()
            
            List {
                ForEach(orderList.orderList, id:\.self) { order in
                    OrderItem(id: order.id, customerName: order.customerName, pizzaName: order.pizzaName, quantity: order.quantity, price: order.price, totalPrice: order.totalPrice, indications: order.indications)
                }
                .onDelete(perform: deleteOrderFunc)
                
            }
            .listStyle(.plain)
        }
        .navigationTitle("Les commandes")
        .refreshable {
             orderList.fetchOrderList()
        }
    }
    
    private func finishOrder() {
        let finishNotification = UNMutableNotificationContent()
        finishNotification.title = "Votre commande est prête"
        finishNotification.subtitle = "Venez la récupérer !"
        finishNotification.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: finishNotification, trigger: trigger)
        
        print("vvv")
        return UNUserNotificationCenter.current().add(request)
    }
    
    private func deleteOrderFunc(indexSet: IndexSet) {
        
        finishOrder()
        let id = indexSet.map {orderList.orderList[$0].id}
        DispatchQueue.main.async {
            self.deleteOrder.deleteOrder(id: id[0], deleted: true)
            orderList.fetchOrderList()
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
