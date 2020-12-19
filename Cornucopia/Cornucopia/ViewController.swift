//
//  ViewController.swift
//  Cornucopia
//
//  Created by fredt_public on 12/18/20.
//  Copyright © 2020 UMassHackathon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var buttonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var buttonDict:[String:String] = [:]


        if(buttonDict.values.count > 0){
        for k in 0...buttonDict.values.count - 1{
        
            UserDefaults.standard.set(Array(buttonDict.values)[k], forKey: String(k))
        }
        }
        scrollView.delegate = self
        var buttonList = buttonDict.keys
        searchButton.layer.cornerRadius = 0.5 * searchButton.bounds.size.width
        searchButton.clipsToBounds = true
        if(buttonDict.values.count > 0){
        for i in 0...buttonDict.keys.count - 1 {
            let frame1 = CGRect(x: 0, y: 20 + (i * 105), width: 330, height: 85)
            let button = UIButton(frame: frame1)
            print(Array(buttonDict.keys)[i])
            button.setTitle("\(Array(buttonDict.keys)[i])", for: .normal)
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
            self.buttonView.addSubview(button)
            
        }
        }
                // Do any additional setup after loading the view.
    }
    @IBAction func searchAction(_ sender: Any) {
//        let alert = UIAlertController(title: "Input an Ingredient", message: "", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Take a Photo", style: UIAlertAction.Style.default, handler: { action in
//            self.takePicture()
//        }))
//        alert.addAction(UIAlertAction(title: "Upload a Photo", style: UIAlertAction.Style.default, handler: nil))
//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView.contentOffset.x != 0{
            scrollView.contentOffset.x = 0
        }
    }

    @objc func buttonClicked(sender: UIButton){
        
        var link = UserDefaults.standard.object(forKey: String(sender.tag)) as! String
        print(link)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "RecipeDisplay")
        self.present(newViewController, animated: true, completion: nil)
        
    }


}

