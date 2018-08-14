//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mac on 13/08/18.
//  Copyright © 2018 ArnAmy. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

      loadCategories()
    }

    //MARK:- TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
   //MARK:- Data Manipulation Methods
    func saveCategories() {
        do{
            try context.save()
        }catch {
            print(error)
        }
        tableView.reloadData()
    }
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
        categories = try context.fetch(request)
        }catch{
         print(error)
        }
        tableView.reloadData()
    }
    
    //MARK:- add New category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textfield.text!
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textfield = field
            textfield.placeholder = "Add a New Category"
        }
        present(alert, animated: true, completion: nil)
    }
    
     //MARK:- TableView DelegateMethods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
}
