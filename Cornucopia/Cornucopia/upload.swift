//
//  upload.swift
//  Cornucopia
//
//  Created by fredt_public on 12/19/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//

import UIKit

class upload: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addAction(_ sender: Any) {
                let alert = UIAlertController(title: "Input an Ingredient", message: "", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Take a Photo", style: UIAlertAction.Style.default, handler: { action in
                    self.takePicture()
                }))
                alert.addAction(UIAlertAction(title: "Upload a Photo", style: UIAlertAction.Style.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
        
    }
    func takePicture(){
        print("taking picture")
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
