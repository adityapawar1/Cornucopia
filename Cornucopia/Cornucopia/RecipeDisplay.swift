//
//  RecipeDisplay.swift
//  Cornucopia
//
//  Created by fredt_public on 12/19/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//

import UIKit

class RecipeDisplay: UIViewController {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var foodName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        likeButton.layer.cornerRadius = 0.5 * likeButton.bounds.size.width
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exit(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.present(newViewController, animated: true, completion: nil)

    }
    
    @IBAction func likeClicked(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            sender.backgroundColor = UIColor.black
        }
        else{
            sender.isSelected = true
            sender.backgroundColor = UIColor.systemRed
        }

    }
    
}
