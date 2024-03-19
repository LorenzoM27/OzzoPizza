//
//  CartButtonView.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 12/03/2024.
//

import SwiftUI

struct CartButtonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowingCart = false
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                isShowingCart.toggle()
            } label: {
                Image(systemName: "basket.fill")
                    .font(.system(size: 25))
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(width: 60, height: 60)
                    .background(colorScheme == .dark ? Color.white : Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .shadow(radius: 10)
            }
        }
        .sheet(isPresented: $isShowingCart) {
            CartView()
        }
    }
}

#Preview {
    CartButtonView()
}
