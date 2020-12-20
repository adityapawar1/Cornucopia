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
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    var idx = 0
    let progressC = Progress(totalUnitCount: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        finish.layer.cornerRadius = 5.0
        finish.layer.masksToBounds = true
        progress.transform = progress.transform.scaledBy(x: 1, y: 5)

        // Do any additional setup after loading the view.
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


