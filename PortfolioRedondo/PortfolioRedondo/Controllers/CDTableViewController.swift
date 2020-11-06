//
//  CDTableViewController.swift
//  PortfolioRedondo
//
//  Created by Akhelys Redondo on 11/1/20.
//  Copyright © 2020 Akhelys Redondo. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CDTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate  {

    //MARK: -Declaration of Variables
    @IBOutlet weak var searchBar: UISearchBar!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[Person]?
    var searchList = [String]()
    var contact = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate=self
        fetchPersons()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Fetching From Core Data
    func fetchPersons() {
        do{
            let request = Person.fetchRequest() as NSFetchRequest<Person>
            let sort = NSSortDescriptor(key: "name", ascending: true )
            request.sortDescriptors = [sort]
            
            self.items = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }
        catch{
            
        }
    }
    
    
    //MARK: Add Button Press
    @IBAction func addTapped(_ sender: Any) {
        
            //creating alert form
            let alert = UIAlertController(title:"Add Person" , message: "What is their name?", preferredStyle: .alert)
        
            alert.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Person Name"
            }
            alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Phone Number"
            }
            let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
                //submit new data to core data
                let nametext = alert.textFields![0]
                let phonetext = alert.textFields![1]
                let newPerson = Person(context: self.context)
                newPerson.name = nametext.text
                let stringphone = phonetext.text! 
                newPerson.phoneNumber = Int64(stringphone)!
                do{
                try self.context.save()
                }catch{
                }
                //refresh
                self.fetchPersons()
            }
            //cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
            //complete alert
            alert.addAction(submitButton)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        
    }
    
    
 

    // MARK: - Table view data source and delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell then store to tableview
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = self.items![indexPath.row]
        cell.textLabel?.text = ("\(person.name!), 0\(person.phoneNumber)")
        return cell
    }
    
    //MARK: - Swiping to Delete
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive , title: "Delete") {
            (action, view, completionHandler) in
            //identify who to delete
            let personToRemove = self.items![indexPath.row]
            //delete
            self.context.delete(personToRemove)
            do{
            try self.context.save()
            }
            catch{
                
            }
            self.fetchPersons()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    //MARK: - Update/Did select configuration
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.items![indexPath.row]
        
        //alert initiation
        let alert = UIAlertController(title:"Edit Person" , message: "Edit Name and Phone Number", preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Person Name"
        }
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Phone Number"
        }
        //identify previous data
        let textfield = alert.textFields![0]
        textfield.text = person.name
        let textfield2 = alert.textFields![1]
        textfield2.text = String(person.phoneNumber)
        //insert new data
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            let persontext = alert.textFields![0]
            let phonetext = alert.textFields![1]
            person.name = persontext.text
            let stringphone = phonetext.text!
            person.phoneNumber = Int64(stringphone)!
            do{
                try self.context.save()
            }catch{
                
            }
            self.fetchPersons()
        }
        
        alert.addAction(saveButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            var predicate: NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "name contains[c] '\(searchText)'")
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Person")
            fetchRequest.predicate = predicate
            do {
                items = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject] as! [Person]
            } catch let error as NSError {
                print("Could not fetch. \(error)")
            }
        }
        tableView.reloadData()
    }
    
  
      

}

