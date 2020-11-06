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



class FirebaseCreateViewController : UIViewController {
    
    var textTitle = ""
    var fname = ""
    var lname = ""
    var nname = ""
    
    @IBOutlet weak var pageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pageTitle.text = textTitle
        let db = Firestore.firestore()
        
        db.collection("users").addDocument(data: ["firstName":fname , "lastName":lname , "nickName":nname])
        
        
    }
    
}
