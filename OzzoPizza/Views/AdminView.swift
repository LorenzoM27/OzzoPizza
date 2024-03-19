//
//  AdminView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 02/09/2023.
//

import SwiftUI

struct AdminView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink {
                        OrdersView()
                    } label: {
                        Text("Les commandes en cours")
                    }
                    
                    NavigationLink {
                        MenuView()
                    } label: {
                        Text("La carte")
                    }

                    NavigationLink {
                        InfosEditView()
                    } label: {
                        Text("Les infos du restaurants")
                    }
                }
                .listStyle(.plain)
                .padding(.top, 20)
                
                Button {
                    dismiss()
                } label: {
                    Text("Déconnexion")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(.red)
                        .cornerRadius(10)
                }
                Spacer()
                
            }
            .navigationTitle("Espace administrateur")
            
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "rectangle.portrait.and.arrow.forward")
//                    }
//                }
//            }
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
