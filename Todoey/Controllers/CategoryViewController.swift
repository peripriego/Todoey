//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Isabel Porcuna on 3/31/19.
//  Copyright © 2019 Isabel Porcuna. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        loadCategories()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].colour ?? "")
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Cttegories Added"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "gotoItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
       
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    func loadCategories() {

        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category: \(error)")
        }
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
                    if let categoryForDeletion = self.categories?[indexPath.row] {
        
                        do{
                            try self.realm.write {
                                self.realm.delete(categoryForDeletion)
                            }
                        } catch {
        
                        }
        
                    }
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
        let newCategory = Category()
        
        newCategory.name = textField.text!
        newCategory.colour = UIColor.randomFlat.hexValue()
        
        self.save(category: newCategory)
        
        
    }
   
       alert.addAction(action)
        alert.addTextField { (field) in
                textField = field
            textField.placeholder = "Add new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    

    
    
    
}

