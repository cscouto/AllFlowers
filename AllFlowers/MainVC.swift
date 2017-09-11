//
//  MainVC.swift
//  AllFlowers
//
//  Created by Tiago Do Couto on 11/09/17.
//  Copyright © 2017 Tiago Do Couto. All rights reserved.
//

import UIKit
import CoreML
import Vision

@available(iOS 11.0, *)
class MainVC: UIViewController {
    
    //outlets
    @IBOutlet weak var imgPhoto: UIImageView!
    
    //vars
    let camPicker = UIImagePickerController()
    
    //system functions
    @IBAction func takePhoto(_ sender: Any) {
        camPicker.sourceType = .camera
        camPicker.delegate = self
        camPicker.allowsEditing = false
        self.present(camPicker, animated: true, completion: nil)
    }
    
    //custom functions
    func detect(image: CIImage){
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Cannot import model")
        }
        let request = VNCoreMLRequest(model: model){
            (request, error) in
            let classification = request.results?.first as? VNClassificationObservation
            self.navigationItem.title = classification?.identifier.capitalized
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do{
            try handler.perform([request])
        }catch{
            
        }
    }
    func requestInfo(flowerName: String){
        BaseAPI.request(flowerName: flowerName)
    }
}

@available(iOS 11.0, *)
extension MainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPhoto.image = image
            guard let ciImage = CIImage(image: image) else {
                fatalError("Not posible to convert from UIImage to CIImage")
            }
            detect(image: ciImage)
        }
        camPicker.dismiss(animated: true, completion: nil)
    }
}
