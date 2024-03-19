//
//  DataController.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 30/04/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "CartModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if error != nil {
                print("failed to load the data")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        
        do {
            try context.save()
            print("data saved")
        } catch {
            print("Unable to save the data")
        }
    }
    
    func addPizza(name: String, price: Double, quantity: Double, personalization: String ,context: NSManagedObjectContext) {
        
        let cart = Cart(context: context)
        cart.pizzaName = name
        cart.price = price
        cart.quantity = quantity
        cart.totalPrice = quantity * price
        cart.personalization = personalization
        
        save(context: context)
    }
    
    func addQuantity(cart: Cart, quantity: Double, personalization: String ,context: NSManagedObjectContext) {
        cart.pizzaName = cart.pizzaName
        cart.price = cart.price
        cart.quantity += 1
        cart.totalPrice = cart.quantity * cart.price
        cart.personalization = personalization
        
        save(context: context)
    }
    
    func removeQuantity(cart: Cart, quantity: Double, personalization: String ,context: NSManagedObjectContext) {
        cart.pizzaName = cart.pizzaName
        cart.price = cart.price
        cart.quantity -= 1
        cart.totalPrice = cart.quantity * cart.price
        cart.personalization = personalization
        
        if cart.quantity == 0 {
            
            context.delete(cart.self)
        }
        
        save(context: context)
    }
    
    func removeOrder(cart: Cart, context: NSManagedObjectContext) {
        
        context.delete(cart)
        
        save(context: context)
    }
    
    
}
