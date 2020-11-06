//
//  lessonView.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 10/14/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//

import Foundation
import UIKit

class lessonView : UIViewController {
    
    @IBOutlet weak var contentlabel: UILabel!
    
    
    @IBOutlet weak var btnPrevO: UIButton!
    
    @IBOutlet weak var btnNextO: UIButton!
    
    @IBOutlet weak var titlelabel: UILabel!
    
    

    
   
    var txtcontent = ""
    var txtcontentlesson = ""
    var pageIndicator = 0
    var titleIndexTag = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(txtcontent)
        print(pageIndicator)
        contentDisplay()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: title index tag 0 = Swift Basics
    
    //MARK: NEXT Button Navigation
    
    @IBAction func btnNext(_ sender: Any) {
        
        //MARK: Page Indicator Control NEXT Button
        pageIndicator += 1
        contentDisplay()
 
    }
    
    
    //MARK: PREVIOUS Button Navigation
    
    @IBAction func btnPrev(_ sender: Any) {
        
        //MARK: Page Indicator Control PREVIOUS Button
        pageIndicator -= 1
        contentDisplay()
   
       
      
        
    }
    
    
    //MARK: Content Display Function
    func contentDisplay() -> String {
        
        if pageIndicator == 0 {
            contentlabel.text = strIntroduction
            titlelabel.text = "Introduction"
            
            print("should be introduction")
            btnPrevO.isHidden = true
        }
        if pageIndicator == 1 {
            contentlabel.text = strEnvironmentSetup
            titlelabel.text = "Environment Setup"
            print("should be environment setup")
            btnPrevO.isHidden = false
        }
        if pageIndicator == 2 {
            contentlabel.text = strSyntax
            print("should be syntax")
            titlelabel.text = "Syntax"
        }
        
        
        return ""
        
    }
    
    
    //MARK: TEXT CONTENT DATABASE
    var strIntroduction = """
                            Swift is a new programming language for
                            iOS,macOS,watchOS and tvOS app
                            development. Swift Combines the best of C
                            and Objective-C without constarints of C
                            compatibility\u{2022} 
                        """
    var strEnvironmentSetup = """
                            You need a Mac Computer and installed
                            Xcode software to start coding in the
                            playground.
                            To download and install the latest version
                            use this link:
                            "https://developer.apple.com/xcode/downloads"
                            \n
                            Alternatively, you can use free Swift
                            compilers which are available online.
                            The popular online siwft compiler is IBM
                            Swift Sandbox.
                            """
    var strSyntax = """
                    Let's use Swift to print "Hello World!"
                    In the above exaple, we use the var
                    keyword to declare a variable. The value of a
                    variable can change throughout the program.
                    print functin writes the textual
                    representations of the given item into the
                    standard output\n
                    
                    Note: Semi-colon(;) at the end of the statement
                    is fully optional in Swift. But if you want to
                    place several independent statements on a
                    single line then semi-colon is required
                    """
    
    
}
