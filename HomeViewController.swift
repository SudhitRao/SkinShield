//
//  HomeViewController.swift
//  SkinShield3
//
//  Created by Sudhit Rao on 4/17/20.
//  Copyright © 2020 Sudhit Rao. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController{
    @IBOutlet weak var roundedCornerButton: UIButton!
    @IBAction func nextViewButtonPressed(_ sender: Any) {
        print("Button Pressed")
        self.performSegue(withIdentifier: "SecondViewSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view has loaded")
        roundedCornerButton.layer.cornerRadius = 4
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
