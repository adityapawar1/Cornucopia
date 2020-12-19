//
//  PopupController.swift
//  Cornucopia
//
//  Created by fredt_public on 12/18/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//

import Foundation
import UIKit


class PopupController: UIViewController, UITextFieldDelegate {

    static var img = UIImage()
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var sendPhotoButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.layer.cornerRadius = 0.5 * exitButton.bounds.size.width

        exitButton.clipsToBounds = true
        exitButton.layer.masksToBounds = true
        uploadButton.layer.cornerRadius = 15.0
        uploadButton.clipsToBounds = true
        takeButton.layer.cornerRadius = 15.0
        takeButton.clipsToBounds = true
        self.textField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func exitClick(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func takePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        self.present(picker, animated: true)
    }
    @IBAction func choosePhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){

                    imagePicker.delegate = self
                    imagePicker.sourceType = .savedPhotosAlbum
                    imagePicker.allowsEditing = false

            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func uploadPhoto(_ sender: Any) {
        print(PopupController.img)
        let image = PopupController.img
            let imageData = image.jpegData(compressionQuality: 1.0)
            print(imageData)
            let urlString = "YOUR_URL_HERE"
            let session = URLSession(configuration: URLSessionConfiguration.default)
                    
            let mutableURLRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
                    
            mutableURLRequest.httpMethod = "POST"
                    
                    let boundaryConstant = "----------------12345";
                    let contentType = "multipart/form-data;boundary=" + boundaryConstant
                    mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
                    
                    // create upload data to send
                    let uploadData = NSMutableData()
                    
                    // add image
            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"picture\"; filename=\"file.png\"\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append(imageData!)
            uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
                    
            mutableURLRequest.httpBody = uploadData as Data
                    
                    
            let task = session.dataTask(with: mutableURLRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
                        if error == nil {
                            // Image uploaded
                        }
                    })
                    
                    task.resume()
                    
    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        print(self.textField.text!)
        return false
    }
    

}
extension PopupController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
            self.dismiss(animated: true, completion: { () -> Void in

            })
        PopupController.img = image
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        PopupController.img = image
    }
}

