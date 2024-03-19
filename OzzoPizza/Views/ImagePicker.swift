//
//  ImagePicker.swift
//  OzzoPizza
//
//  Created by Lorenzo Menino on 10/09/2023.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage : UIImage?
    @Binding var isPickerShowing : Bool
    @Binding var imageUrl : URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        // quand l'user choisis une photo, le selecteur contact le delegate et appelé une méthode spécifique et passer la photo dans cette méthode
        // Objet qui peut recevoir les events UIImagePickerController
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}


class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent : ImagePicker
    
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Run code quand l'utilisateur a choisit une image
        print("image selected")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // On peut avoir l'image
    
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
            
        }
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            //DispatchQueue.main.async {
                self.parent.imageUrl = url
           // }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Run code quand l'utilisateur à annuler le picker
        print("cancelled")
        parent.isPickerShowing = false
    }
}
