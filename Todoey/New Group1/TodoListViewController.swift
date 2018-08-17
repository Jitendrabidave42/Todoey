//
//  ViewController.swift
//  Todoey
//
//  Created by Mac on 07/08/18.
//  Copyright © 2018 ArnAmy. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class TodoListViewController: UITableViewController {
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
           loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
       // print(dataFilepath)
        
        //searchBar.delegate = self
        
        
        //loadItems()
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]  {
//            todoArray = items
//        }
    }
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return todoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let myitem = todoItems?[indexPath.row]{
            cell.textLabel?.text = myitem.title
            
            cell.accessoryType = myitem.done == true ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No Items Added"
        }
     

        return cell
        
    }
   //MARK - Tableview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]  {
            do{
                try realm.write {
                    //realm.delete(item)
                    item.done = !item.done
                }
            }catch {
                print("Error saving status \(error)")
               
            }
            
        }
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
            
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
                }catch {
                    print("Error saving Items \(error)")
                }
            }
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
   
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
      
        tableView.reloadData()
        }
   
        }
//MARK: Search Bar Methods
extension TodoListViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                  searchBar.resignFirstResponder()
            }

        }
    }
}






