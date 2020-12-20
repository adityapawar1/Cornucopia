//
//  RecipeDisplay.swift
//  Cornucopia
//
//  Created by Brayden Tam, Akhil Datla, Aditya Pawar, Vivek Nadig on 12/19/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//

import UIKit

class RecipeDisplay: UIViewController {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var directionPage: UITextView!
    var tag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeButton.layer.cornerRadius = 0.5 * likeButton.bounds.size.width
        if(UserDefaults.standard.object(forKey: "tag") != nil){
            tag = UserDefaults.standard.object(forKey: "tag") as! Int
            var Arr = UserDefaults.standard.object(forKey: String(tag)) as! Dictionary<String, Any>
            directionPage.text = Arr["directions"] as! String
            for ingredientIterator in Arr["ingredients"] as! Array<Any>{
                ingredients.text! += ingredientIterator as! String + ", "
            }
            foodName.text = Arr["title"] as! String
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
     return true
    }
    
    @IBAction func exit(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "RecipePicker")
        self.present(newViewController, animated: true, completion: nil)

    }
    
    @IBAction func openLink(_ sender: Any) {
        var tagForURL = UserDefaults.standard.object(forKey: "tag") as! Int
        var ArrForURL = UserDefaults.standard.object(forKey: String(tagForURL)) as! Dictionary<String, Any>
        var newURL = ArrForURL["url"] as! String
        UIApplication.shared.open(URL(string: newURL)!)
    }
    @IBAction func likeClicked(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            sender.backgroundColor = UIColor.black
            print("unsaved")
        }
        else{
            sender.isSelected = true
            sender.backgroundColor = UIColor.systemRed
            print("saved")
            
            
            
            
        }

    }
    
}
