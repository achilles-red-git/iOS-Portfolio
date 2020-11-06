//
//  FirebaseViewController.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 11/2/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import SwiftyJSON
import SVProgressHUD

class FirebaseViewController : UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
  
    //MARK: - DECLARATION OF VARIABLES
    var fbcount = 0
    var selectedName = ""
    let db = Firestore.firestore()
    @IBOutlet weak var namePicker: UIPickerView!
    var ctr = 0
    var tester = ""
    var ctrswap = 0
    
    @IBOutlet weak var invitext: UITextField!
    
    var nameArray : [String] = []
    var swapArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        namePicker.dataSource = self
        namePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSpin(_ sender: Any) {
        //move picker function call to select a winner
        movePicker()

    }
    
    //MARK: - Delete Function
    @IBAction func btnDelete(_ sender: Any) {
    
        //First get the number of existing users, to be used for loop
        let docRef = db.collection("users").document("usercount")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                //number of users
                self.fbcount = document.get("count") as! Int
            } else {
                print("Document does not exist")
            }
        }
        
        //Loop through the documents to match and find which speicifically needs to be deleted
        db.collection("users").whereField("phoneNumber", isGreaterThan: 1)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let documentData = document.get("name")
                        if documentData != nil && self.ctr < self.fbcount{
                          //setting to variable for comparison
                            let documentName = documentData as! String
                            let documentPhone = document.get("phoneNumber") as? NSNumber
                            //if equal execute deletion
                            if documentName == self.selectedName {
                                let refreshAlert = UIAlertController(title: "Delete Person", message: "\(documentName) will be deleted from the list", preferredStyle: UIAlertControllerStyle.alert)
                                
                                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                    let deletePhone1 = documentPhone?.stringValue
                                    let deletePhone = ("0" + deletePhone1!)
                                    self.db.collection("users").document(deletePhone).delete()
                                }))
                                
                                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                                    refreshAlert.dismiss(animated: true , completion: nil)
                                }))
                                //implement alert for confirmation
                                self.present(refreshAlert, animated: true, completion: nil)

                            }
                
                            
                        }
                    }
                }
                
        }
    }
    
    //MARK: - Create FUnction
    @IBAction func btnCreate(_ sender: Any) {
        //Create alert to be used as form to extract data from user
        let alertController = UIAlertController(title: "Add New Person", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Phone Number"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            //alert form
            let phoneText = alertController.textFields![0] as UITextField
            let nameText = alertController.textFields![1] as UITextField
            
            //string conversion before inserting to database to match proper types
            print("Phone:\(phoneText.text) = Name:\(nameText.text)")
            let phonevar = Int(phoneText.text!)
            let docId = String(phoneText.text!)
            let namevar = String(nameText.text!)
            
            //update document usercounts to keep track of number of users
            let docRef = self.db.collection("users").document("usercount")
            docRef.getDocument(source: .cache) { (document, error) in
                if let document = document {
                    let oldCount = document.get("count") as? NSNumber
                    let intcon = oldCount?.intValue
                    let newCount = intcon! + 1
                    self.db.collection("users").document("usercount").updateData(["count": newCount])
                    
                } else {
                    print("Document does not exist in cache")
                }
            }
            //Insert New user to database extracted from the alert textfields
            self.db.collection("users").document(docId).setData(["name": namevar , "phoneNumber": phonevar], merge: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name"
        }
        //implement alerts
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Update Function
    @IBAction func btnUpdate(_ sender: Any) {
        //similar process for delete function -  //First get the number of existing users, to be used for loop
        let docRef = db.collection("users").document("usercount")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.fbcount = document.get("count") as! Int
            } else {
                print("Document does not exist")
            }
        }
        //Loop through the documents to match and find which speicifically needs to be deleted
        db.collection("users").whereField("phoneNumber", isGreaterThan: 1)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print("passes here")
                    for document in querySnapshot!.documents {
                        //setting to variable for comparison
                        let documentData = document.get("name")
                        if documentData != nil{
         
                            let strname = documentData as! String
                            print("two: strname:\(strname) => selectedName:\(self.selectedName)")
                            //determine if equal
                            if strname == self.selectedName {
                            //if equal execute update
                            //data type conversion before inserting to databse to get proper data types
                            let documentName = documentData as! String
                            let documentPhone = document.get("phoneNumber") as? NSNumber
                            print("documentName:\(documentName) = selectedName:\(self.selectedName)")
                            if documentName == self.selectedName {
                                //alert as form to get input from user
                                 let alertController = UIAlertController(title: "Update Person", message: "\(documentName) will be updated", preferredStyle: .alert)
                                alertController.addTextField { (textField : UITextField!) -> Void in
                                    textField.placeholder = "Enter New Name"
                                }
                                let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                                    let nametext = alertController.textFields![0] as UITextField
                                    //another data type conversions to get proper data types
                                    let newname = nametext.text as! String
                                    let updatePerson1 = documentPhone?.stringValue
                                    let updatePerson = ("0"+updatePerson1!)
                                    //insert to database
                                    self.db.collection("users").document(updatePerson).updateData(["name": newname])
                                    print("Number\(updatePerson)\(newname)")
                                })
                                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in
                                    alertController.dismiss(animated: true , completion: nil)
                                })
                                //implement alert
                                alertController.addAction(saveAction)
                                alertController.addAction(cancelAction)
                                self.present(alertController, animated: true, completion: nil)
                            }
                            
                            
                        }
                    }
                }
                }
                
        }
    }

   
    
    @IBAction func refresh(_ sender: Any) {
        //refresh data
       refreshPicker()
    }
    
  

    func refreshPicker(){
        DispatchQueue.main.async {
            self.swapArray.removeAll()
            self.fetchNames()
            self.namePicker.reloadAllComponents()
          
        }
    }
   
    func fetchNames(){
    //reset counter for, forloop for fetching
       self.ctr = 0
        //progresshud while fetching data
       SVProgressHUD.show()
        //get user count to know how many loop
        let docRef = db.collection("users").document("usercount")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.fbcount = document.get("count") as! Int
            } else {
                print("Document does not exist")
            }
        }
        //extract all data
        db.collection("users").whereField("phoneNumber", isGreaterThan: 1)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    //clear array for blank template before populating array with new data (refreshing data)
                    self.nameArray = []
                    for document in querySnapshot!.documents {
                        let documentData = document.get("name")
                        if documentData != nil && self.ctr < self.fbcount {
                            //append data to array to populate
                            let documentName = documentData as! String
                            let passing = documentName
                            self.nameArray.append(passing)
                            self.ctr += 1
        
                        }
                    }
                    SVProgressHUD.dismiss()
                }
                
        }
        print("FBCOUNT \(self.fbcount)")
        print("NameArray count \(nameArray.count)")
   
    }
    
    //MARK: - move picker
    
    func movePicker()  {
        //get count to know maximum random number to prevent getting out of array range
        let count = nameArray.count
        //randomize number within array range
        let position = Int(arc4random_uniform(UInt32(count-1)) + 1)
        //refresh picker view to set new UI
        self.namePicker.reloadAllComponents()
        self.namePicker.selectRow(position, inComponent: 0, animated: true)
        self.namePicker.showsSelectionIndicator = true
        //alert the winner
        let alert = UIAlertController(title: "YOU WON!", message: "\(self.nameArray[position]) WON THE DRAW", preferredStyle: UIAlertControllerStyle.alert)
         alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
        }
    
   

    
    
    //UI Picker view delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
 
        
         return nameArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
  
         return nameArray[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       selectedName = nameArray[row]
        
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
}
