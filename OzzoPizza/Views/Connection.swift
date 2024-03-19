//
//  Connection.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 01/09/2023.
//

import SwiftUI
import CryptoKit


struct Connection: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userModel = UserViewModel()
    
    @State var mail = ""
    @State var password = ""
    
    @State private var wrongMail = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var isError = false
    @State private var userType = ""
    
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Connexion")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            TextField("Email", text: $mail)
                .padding()
                .frame(width: 300, height: 50)
                .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                .cornerRadius(10)
                .border(.red, width: CGFloat(wrongMail))
            
            SecureField("Mot de passe", text: $password)
                .padding()
                .frame(width: 300, height: 50)
                .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.05))
                .cornerRadius(10)
                .border(.red, width: CGFloat(wrongPassword))
            
            Button("Se connecter") {
                authenticateUser(mail: mail, password: password)
            }
            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
            .frame(width: 200, height: 50)
            .background(colorScheme == .dark ? Color.white : Color.black)
            .cornerRadius(10)
            .padding()
            .fullScreenCover(isPresented: $showingLoginScreen) {
                if userType == "admin" {
                    AdminView()
                } else {
                    UserView()
                }
            }
            
            if isError {
                Text("Email ou mot de passe incorrect")
                    .font(.subheadline)
            }
            Spacer()
            Spacer()
        }
        .onAppear{
            Task {
                await userModel.fetchUser()
            }
            
        }
        
    }
    
    func authenticateUser(mail: String, password: String) {
        
        for user in userModel.user {
            
            let preSalt = "123password123!"
            let postSalt = "AAZlàç!"
            
            let saltedPassword = preSalt + password + postSalt
            
            let inputData = Data(saltedPassword.utf8)
            let hashed = SHA256.hash(data: inputData)
            let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
            
            print(hashed.description)
            
            if mail.lowercased() == user.mail  && hashString == user.password {
                showingLoginScreen = true
                userType = user.type
                
            } else  {
                wrongMail = 2
                wrongPassword = 2
                isError = true
            }
        }
    }
}

struct Connection_Previews: PreviewProvider {
    static var previews: some View {
        Connection()
    }
}
