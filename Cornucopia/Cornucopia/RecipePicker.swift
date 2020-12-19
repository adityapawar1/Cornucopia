//
//  RecipePicker.swift
//  Cornucopia
//
//  Created by fredt_public on 12/19/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//

import UIKit

class RecipePicker: UIViewController {

    @IBOutlet var pickerView: UIView!
    var recipeDict = ["recipes":
        [
            [
        "title": "Hard Boiled Eggs",
        "url": "https://google.com",
        "ingredients": [
        "sa",
        "as"
            ],
        "directions": "sanjfbjkanjfnjksanfasj"
        ],
        [
          "title": "Soft Boiled Eggs",
          "url": "https://espn.com",
          "ingredients":
                        [
          "asdf",
          "fdas"
                        ],
          "directions": "don't boil"
        ]
        ]
    ]
    var recipes:[[String : Any]] = []
    var k = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipes = Array(recipeDict.values)[0]
        UserDefaults.standard.set(recipes[0], forKey: "recipeDict")
        for i in 0...recipes.count - 1{
            let frame1 = CGRect(x: 20, y: 20 + (i * 105), width: 330, height: 85)
            let button = UIButton(frame: frame1)
            button.setTitle("\(recipes[i]["title"] as! String)", for: .normal)
            UserDefaults.standard.set(recipes[i], forKey: String(i))
            button.isUserInteractionEnabled = true
            button.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
            if i % 3 == 1{
                button.backgroundColor = UIColor(red: 58/255.0, green: 175/255.0, blue: 252/255.0, alpha: 1)
            }
            else if i % 3 == 2{
                button.backgroundColor = UIColor(red: 255/255.0, green: 192/255.0, blue: 43/255.0, alpha: 1)
            }
            else{
                button.backgroundColor = UIColor(red: 240/255.0, green: 137/255.0, blue: 255/255.0, alpha: 1)
            }
            
            button.layer.cornerRadius = 15.0
            button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 25)
            
            button.tag = i
            self.pickerView.addSubview(button)
            
        }


        // Do any additional setup after loading the view.
    }
    @objc func buttonClicked(sender: UIButton){
        
        UserDefaults.standard.set(sender.tag, forKey: "tag")
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "RecipeDisplay")
        self.present(newViewController, animated: true, completion: nil)
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
