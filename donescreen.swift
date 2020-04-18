//
//  donescreen.swift
//  SkinShield3
//
//  Created by Sudhit Rao on 4/17/20.
//  Copyright © 2020 Sudhit Rao. All rights reserved.
//

import Foundation
import UIKit

class donescreen: UIViewController{
    
    var id : String  =  ""
    
    @IBOutlet weak var endLabel: UILabel!
    
    @IBOutlet weak var finalimage: UIImageView!
    //finalImage is set to poison ivy by default, if eczema it will change to an eczema image
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view has loaded")
        let vc = ViewController()
        id = vc.self.conf
        let b = "xd " + id
        print(b)
        if(id=="poison ivy"){
        self.endLabel.text = "According to our AI model, your skin condition is poison ivy. \nPoison ivy rash is a type of allergic contact dermatitis caused by an oily resin called urushiol. It's found in the leaves, stems and roots of poison ivy, poison oak and poison sumac. \nWhen to see a doctor:\n\u{2022} The reaction is severe or widespread\n\u{2022} Your skin continues to swell\n\u{2022} Blisters are oozing pus\n\u{2022} You develop a fever greater than 100 F (37.8 C)\n\u{2022} The rash doesn't get better within a few weeks"
        }
        else{
            self.endLabel.text = "According to our AI model, your skin condition is eczema. \n Eczema is a condition where patches of skin become inflamed, itchy, red, cracked, and rough. Blisters may sometimes occur.\nWhen to see a doctor:\n\u{2022} You’ve got itchiness or symptoms that inhibit your sleep or daily activities most days of the week\n\u{2022} You’re experiencing new symptoms associated with your eczema\n\u{2022} The duration of time between flare-ups is getting shorter"
            finalimage.image = UIImage(named: "eczemapic")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
