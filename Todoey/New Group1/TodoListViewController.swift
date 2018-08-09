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
    let dataFilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilepath)
        
     
        
        loadItems()
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]  {
//            todoArray = items
//        }
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
        saveItems()
        
        
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
           self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
           // print(alertTextField.text)
            textField = alertTextField
            
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(todoArray)
            try data.write(to: dataFilepath! )
        }catch{
            print(error)
        }
        self.tableView.reloadData()
    }
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilepath!){
            let decoder = PropertyListDecoder()
            do{
            todoArray = try decoder.decode([Item].self, from: data)
            }catch {
                print(error)
            }
        }
            
        }
        
    }





