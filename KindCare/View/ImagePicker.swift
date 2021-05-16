//
//  ImageView.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 13.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import SwiftUI

/*
 Реализация ImagePicker с помощью UIImagePickerController
 */
struct ImagePicker : UIViewControllerRepresentable{
    @Environment(\.presentationMode) internal var presentationMode
    @Binding internal var data: Data?
    
    internal func makeCoordinator() -> Coordinator
    {
        return Coordinator(self)
    }
    
    internal func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    internal func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>){
    }
    
    internal class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.data = uiImage.jpegData(compressionQuality: 1)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


