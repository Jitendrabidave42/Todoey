//
//  ViewController.swift
//  Todoey
//
//  Created by Mac on 07/08/18.
//  Copyright © 2018 ArnAmy. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var todoArray = [Item]()
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Jitu"
        todoArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "John"
        todoArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Meri"
        todoArray.append(newItem2)
     
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]  {
            todoArray = items
        }
    }
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return todoArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let myitem = todoArray[indexPath.row]
        cell.textLabel?.text = myitem.title
        
        cell.accessoryType = myitem.done == true ? .checkmark : .none
//        if myitem.done == true{
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
//
        return cell
        
        
        
    }
   //MARK - Tableview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(todoArray[indexPath.row])
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        todoArray[indexPath.row].done = !todoArray[indexPath.row].done
        
//        if todoArray[indexPath.row].done == false {
//            todoArray[indexPath.row].done = true
//        }else
//        {
//            todoArray[indexPath.row].done = false
//        }
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
       //MARK - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //print("Success!")
            //print(textField.text)
            let newItem = Item()
            newItem.title = textField.text!
            self.todoArray.append(newItem)
            self.defaults.set(self.todoArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
           // print(alertTextField.text)
            textField = alertTextField
            
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}




