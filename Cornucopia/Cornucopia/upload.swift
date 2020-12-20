//
//  upload.swift
//  Cornucopia
//
//  Created by Brayden Tam, Akhil Datla, Aditya Pawar, Vivek Nadig on 12/19/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//

import UIKit
import Foundation

class upload: UIViewController {

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var finish: UIButton!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var text4: UILabel!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var text5: UILabel!
    var idx = 0
    var ingredient = String()
    
    let model = Resnet50()
    let progressC = Progress(totalUnitCount: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButton.layer.cornerRadius = 0.5 * clearButton.bounds.size.width
        finish.layer.cornerRadius = 5.0
        finish.layer.masksToBounds = true
        progress.transform = progress.transform.scaledBy(x: 1, y: 5)

        // Do any additional setup after loading the view.
    }
    func imageClassification() {
        var counter = 0
        let imageList = [imageView1.image,imageView2.image,imageView3.image,imageView4.image,imageView5.image]
        for i in imageList{
            counter += 1
        guard let img = i,
              let resizedImage = img.resizeTo(size: CGSize(width: 224, height: 224)),
              let buffer = resizedImage.toBuffer() else {
            return
        }
            let output = try? model.prediction(image: buffer)

            if let output = output {

                self.ingredient = output.classLabel
                

            }
            if counter == 1{
                text1.text = ingredient
            }
            else if counter == 2{
                text2.text = ingredient
            }
            else if counter == 3{
                text3.text = ingredient
            }
            else if counter == 4{
                text4.text = ingredient
            }
            else if counter == 5{
                text5.text = ingredient
            }

            
    }

    }
    @IBAction func clearImages(_ sender: Any) {
        idx = 0
        imageView1.image = nil
        imageView2.image = nil
        imageView3.image = nil
        imageView4.image = nil
        imageView5.image = nil
    }
    
    @IBAction func finish(_ sender: Any) {
        if idx == 0 {
            let ac = UIAlertController(title: "Error", message: "You must have at least 1 photo.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
        else {
            self.imageClassification()
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true){(timer) in
                guard self.progressC.isFinished == false else {
                    timer.invalidate()
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyboard.instantiateViewController(withIdentifier: "RecipePicker")
                    self.present(newViewController, animated: true, completion: nil)
                    print("finished")
                    return
                }
                self.progressC.completedUnitCount += 1
                let progressFloat = Float(self.progressC.fractionCompleted)
                self.progress.setProgress(progressFloat, animated: true)
                self.progress.progress = progressFloat
            }
            
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
                let alert = UIAlertController(title: "Input an Ingredient", message: "", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Take a Photo", style: UIAlertAction.Style.default, handler: { action in
                    self.takePicture()
                }))
                alert.addAction(UIAlertAction(title: "Upload a Photo", style: UIAlertAction.Style.default, handler: { action in
                    self.uploadPicture()
                                                                                                           }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
        
    }
    func takePicture(){
        idx = idx + 1
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        self.present(picker, animated: true)
    }
    func uploadPicture(){
        print(idx)
        var imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    print("Button capture")
                    idx = idx + 1
                    imagePicker.delegate = self
                    imagePicker.sourceType = .savedPhotosAlbum
                    imagePicker.allowsEditing = false

            self.present(imagePicker, animated: true, completion: nil)
                }
    }
}

extension upload: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        idx = 0
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
            self.dismiss(animated: true, completion: { () -> Void in

            })
        print(idx)
        if idx == 1 {
            
            imageView1.image = image
            
        
        }
        
        else if idx == 2 {
            imageView2.image = image


        }

        else if idx == 3 {
            imageView3.image = image


        }

        else if idx == 4 {
            imageView4.image = image


        }

        else if idx == 5 {
            imageView5.image = image

        }
        
        else {
            let ac = UIAlertController(title: "Error", message: "You can only have a maximum of 5 photos at a time.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        if idx == 1 {
            imageView1.image = image
            
        
        
        }
        
        else if idx == 2 {
            imageView2.image = image
            
        
        }
        
        else if idx == 3 {
            imageView3.image = image
            
        
        }
        
        else if idx == 4 {
            imageView4.image = image
            
            
        }
        
        else if idx == 5 {
            imageView5.image = image
            
        
        }
        
        else {
            let ac = UIAlertController(title: "Error", message: "You can only have a maximum of 5 photos at a time.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
        
    }
}

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension UIImage {

    func resizeTo(size :CGSize) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }

    func toBuffer() -> CVPixelBuffer? {

        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(self.size.width), Int(self.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }

        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)

        UIGraphicsPushContext(context!)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

        return pixelBuffer
    }

}
