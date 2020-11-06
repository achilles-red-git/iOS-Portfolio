//
//  TableViewController.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 10/11/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var indexstrID = ""
    var indexTag = ""
    var stringID = ""
    var startingpage = 0
    
    
    var listArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
       listArray.removeAll()
        if indexstrID == "Swift Tutorial"{
            listArray += ["Introduction", "Environment Setup" , "Your First Swift Program","Data Types", "Variables" , "Constant", "Constant and Variable","Type Annotation","Operators", "Remainder Operator", "Compound Assignment Operator" , "Comparison Operator",
                "Ternary Operator", "Range Operator", "Logical Operator"]
        }
       
    }
    
    
   
    
    //MARK :- table population
    
    override func tableView(_ tableView: UITableView , numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = listArray[indexPath.item]
        return cell
        
    }
    
    
    
    //Going to the lesson view
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (listArray[indexPath.item])
        stringID = listArray[indexPath.item]
        startingpage = indexPath.item
        performSegue(withIdentifier: "tableToLessonSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableToLessonSegue" {
            let segueConn = segue.destination as! lessonView
            segueConn.txtcontent = stringID
            segueConn.pageIndicator = startingpage
            segueConn.titleIndexTag = indexTag
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
