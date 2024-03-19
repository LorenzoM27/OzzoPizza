//
//  Infos.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 14/06/2023.
//
import MapKit
import SwiftUI

struct InfosView: View {
    
    //@ObservedObject var infosModel = InfosViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.59004741038958, longitude: 3.1672466526797223), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
    
    var image : [InfosDto.ImageDto]
    var tel : String
    var tel2 : String
    var address : String
    
    
    var body: some View {
        VStack{
//            Text("Nous trouver")
//                .font(.title)
//                .fontWeight(.bold)
            
            
            ForEach(image) { image in
                
                AsyncImage(url: URL(string: image.url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(25)
                        .frame(width: 350, height: 150)
                    
                } placeholder: {
                    ProgressView()
                }
            }
            
            HStack{
                HStack{
                    Image(systemName: "phone.fill")
                        .font(.title3)
                    Link("\(tel)", destination: URL(string: "tel:\(tel)")!)
                }
                HStack{
                    Image(systemName: "phone.fill")
                        .font(.title3)
                    Link("\(tel2)", destination: URL(string: "tel:\(tel2)")!)
                }
            }
            .padding()
            
            HStack{
                Image(systemName: "mappin.circle.fill")
                    .font(.title3)
                Link("\(address)", destination: URL(string: "map:")!)
            }
            Map(coordinateRegion: $region)
                .frame(width: 350, height: 300)
                .cornerRadius(25)
            
        }.navigationTitle("Nous trouver")
    }
}


//struct InfosView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfosView()
//    }
//}
