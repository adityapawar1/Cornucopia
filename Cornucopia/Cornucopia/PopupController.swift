//
//  PopupController.swift
//  Cornucopia
//
//  Created by Brayden Tam, Akhil Datla, Aditya Pawar, Vivek Nadig on 12/18/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//
//
//import Foundation
//import UIKit
//
//
//class PopupController: UIViewController, UITextFieldDelegate {
//
//
//    @IBOutlet weak var textField: UITextField!
//    @IBOutlet weak var uploadButton: UIButton!
//    @IBOutlet weak var takeButton: UIButton!
//    @IBOutlet weak var exitButton: UIButton!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        exitButton.layer.cornerRadius = 0.5 * exitButton.bounds.size.width
//
//        exitButton.clipsToBounds = true
//        exitButton.layer.masksToBounds = true
//        uploadButton.layer.cornerRadius = 15.0
//        uploadButton.clipsToBounds = true
//        takeButton.layer.cornerRadius = 15.0
//        takeButton.clipsToBounds = true
//        self.textField.delegate = self
//        // Do any additional setup after loading the view.
//    }
//
//    @IBAction func exitClick(_ sender: Any) {
//        dismiss(animated: true)
//    }
//
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
//        self.view.endEditing(true)
//        print(self.textField.text!)
//        return false
//    }
//
//
//}
