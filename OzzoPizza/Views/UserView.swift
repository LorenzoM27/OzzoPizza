//
//  UserView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 02/09/2023.
//

import SwiftUI

struct UserView: View {
    
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
                //Spacer()
                
            }
            .navigationTitle("Espace employé")
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
