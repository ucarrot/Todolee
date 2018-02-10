//
//  ViewController.swift
//  Todolee
//
//  Created by Omar Al Romaithi on 2/4/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    //data directory creating data path - (encoder)
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    //step1 - storing inserted data in the app (this is not recomemended practice. using UserDefaults is only to add value such as ex. vloume: on ...etc
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        
        loadItems()
        
    }
    //tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //note: using (Ternary operator) ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
//        -----the above code shorten and replaces the below ------

        //        if item.done == true {
        //            cell.accessoryType = .checkmark
        //        }
        //        else {
        //            cell.accessoryType = .none
        //        }
        return cell
    }
    
    //tableview delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /////print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done  = !itemArray[indexPath.row].done //checks if false make it true
        
        tableView.deselectRow(at: indexPath, animated: true)
        saveItems()
        
        
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            //step2 - storing the array list - this crashed because UserDefaults doesnt accept customized objects
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
           
        }
        
        //add text field
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manupulation Methods
    func saveItems(){
        let encoder = PropertyListEncoder() // this code replace the above and depends on the directory path
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData() // update the array list
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}

