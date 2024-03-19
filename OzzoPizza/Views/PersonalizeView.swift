//
//  PersonalizeView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 05/12/2023.
//

import SwiftUI

struct PersonalizeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Binding var personalize : String
    
    var body: some View {
        VStack {
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
                
                Text("Personnaliser")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Spacer()
            }
            .padding()

            
            Text("Dites nous les ingrédients que vous voulez retirer de votre pizza !")
                .font(.title2)
                .fontWeight(.semibold)
            
            TextField("personnaliser", text: $personalize)
                .lineLimit(4, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            
            Button {
                dismiss()
            } label: {
                Text("Confirmer")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(width: 300, height: 50)
                    .background(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10)
            }
            Spacer()
            
        }
        .padding()
    }
}

//struct PersonalizeView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        PersonalizeView()
//    }
//}
