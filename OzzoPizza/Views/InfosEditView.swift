//
//  InfosEditView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 13/09/2023.
//

import SwiftUI

struct InfosEditView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var infosModel = InfosViewModel()
    @ObservedObject var edit = InfosEditViewModel()
    
    @State var tel : String = ""
    @State var tel2 : String = ""
    @State var address : String = ""
    @State var infosId = ""
    
    var body: some View {
        VStack{
//            Text("Modifier les infos")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
            
            ForEach(infosModel.infos) { infos in
               Text("Addresse :")
                    //.padding()
                
                TextField(infos.address, text: $address)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                Text("Numéro 1 :")
                    .padding()
                
                TextField(infos.tel, text: $tel)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                Text("Numéro 2 :")
                    .padding()
                
                TextField(infos.tel2, text: $tel2)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                    .cornerRadius(10)
                

            }
            
            Spacer()
            
            Button {
                for id in infosModel.infos {
                    infosId = id.id
                }
                edit.editInfos(id: infosId, newAddress: address, newTel: tel, newTel2: tel2)
            } label: {
                Text("Modifier les infos")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(width: 300, height: 50)
                    .background(colorScheme == .dark ? .white : .black)
                    .cornerRadius(10)
            }
            

            
        }
        .navigationTitle("Modifier les infos")
        .padding(.top, 50)
        .onAppear{
            Task {
                infosModel.fetchInfos()
            }
        }
    }
}

struct InfosEditView_Previews: PreviewProvider {
    static var previews: some View {
        InfosEditView()
    }
}
