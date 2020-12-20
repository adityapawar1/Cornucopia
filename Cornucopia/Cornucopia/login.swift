//
//  login.swift
//  Cornucopia
//
//  Created by Brayden Tam, Akhil Datla, Aditya Pawar, Vivek Nadig on 12/19/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//

import UIKit

class login: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.text.delegate = self
        submit.layer.cornerRadius = 5.0
        submit.layer.masksToBounds = true
        if(UserDefaults.standard.object(forKey: "username") != nil){
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.present(newViewController, animated: true, completion: nil)
        }


        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitAction(_ sender: Any) {
        UserDefaults.standard.set(text.text!, forKey: "username")
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.present(newViewController, animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
            self.view.endEditing(true)
            print(self.text.text!)
            return false
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
