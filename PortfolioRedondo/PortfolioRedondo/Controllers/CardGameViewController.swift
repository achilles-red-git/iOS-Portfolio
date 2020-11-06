//
//  CardGameViewController.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 10/18/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//

import Foundation
import UIKit

class CardGameViewController : UIViewController {
    
    //MARK: - Variable declaration
    @IBOutlet weak var leftCard: UIImageView!
    
    @IBOutlet weak var rightCard: UIImageView!
    
    @IBOutlet weak var leftScoreLabel: UILabel!
    
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    var leftScore = 0
    var rightScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting score to zero each time it loads
        leftScore = 0
        rightScore = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func dealTapped(_ sender: Any) {
        //Randomize Numbers
        let leftNumber = arc4random_uniform(13)+2
        print(leftNumber)
        
        let rightNumber = arc4random_uniform(13)+2
        print(rightNumber)
        
        //Set random numbers to image
        DispatchQueue.main.async {
            self.leftCard.image = UIImage(named: "card\(leftNumber)")
            self.rightCard.image = UIImage(named: "card\(rightNumber)")
        }
       
        
        if leftNumber > rightNumber {
            //left side win
            
            leftScore += 1
            leftScoreLabel.text = String(leftScore)
            
        }else if leftNumber == rightNumber{
            //tie
            
        }else{
            //right side win
            
            rightScore += 1
            rightScoreLabel.text = String(rightScore)
        }
    }
    
    
    
}
