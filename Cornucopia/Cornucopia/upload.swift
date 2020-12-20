//
//  upload.swift
//  Cornucopia
//
//  Created by fredt_public on 12/19/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//

import UIKit
import Foundation

class upload: UIViewController {

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var finish: UIButton!
    let progressC = Progress(totalUnitCount: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        finish.layer.cornerRadius = 5.0
        finish.layer.masksToBounds = true
        progress.transform = progress.transform.scaledBy(x: 1, y: 5)

        // Do any additional setup after loading the view.
    }
    @IBAction func finish(_ sender: Any) {
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
    
    @IBAction func addAction(_ sender: Any) {
                let alert = UIAlertController(title: "Input an Ingredient", message: "", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Take a Photo", style: UIAlertAction.Style.default, handler: { action in
                    self.takePicture()
                }))
                alert.addAction(UIAlertAction(title: "Upload a Photo", style: UIAlertAction.Style.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { action in 
                    self.uploadPicture()
                                                                                                           }))
                self.present(alert, animated: true, completion: nil)
        
    }
    func takePicture(){
        print("taking picture")
    }
    func uploadPicture(){
        print("uploading picture")
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
