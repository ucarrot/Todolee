//
//  ViewController.swift
//  Todolee
//
//  Created by Omar Al Romaithi on 2/4/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["TV Show","Movies","Internet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    //tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //tableview delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /////print(itemArray[indexPath.row])
        
        //add checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //animate when selecting item
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //add new items button and connect
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //local var
        var textField = UITextField()
        
        //alert
        let alert = UIAlertController(title: "Add new todolee ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when user click on the add button on our UIAlert
            
            self.itemArray.append(textField.text!) 
            self.tableView.reloadData() // update the array list
        }
        
        //add text field
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

