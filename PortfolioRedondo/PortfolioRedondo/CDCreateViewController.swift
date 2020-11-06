//
//  FirebaseCreateViewController.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 10/30/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//

import Foundation
import UIKit
import Firebase



class CDCreateViewController : UIViewController {
    
    var textTitle = ""
    var fname = ""
    var lname = ""
    var nname = ""
    
    @IBOutlet weak var titleDisplay: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        titleDisplay.text = textTitle
    
        
        
    }
    
}

