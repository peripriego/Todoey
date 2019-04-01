//
//  ViewController.swift
//  Todoey
//
//  Created by Isabel Porcuna on 3/27/19.
//  Copyright © 2019 Isabel Porcuna. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory : Category? {
        
        didSet {
      //      loadItems()
        }
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return itemArray.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = itemArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
    
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
//            let newItem = Item(context: self.context)
//
//            newItem.title = textField.text!
//
//            newItem.done = false
//
//            newItem.parentCategory = self.selectedCategory
//
//            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    
    }
    
// MARK: - Save/Load functions
    
    func saveItems () {
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        self.tableView.reloadData()
    }
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        }
//        else {
//            request.predicate = categoryPredicate
//        }
//
//
//        do {
//        itemArray = try context.fetch(request)
//        }
//        catch {
//            print(error)
//        }
//        tableView.reloadData()
//    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
       
    }
}


// MARK: - Search Bar Methods

//extension TodoListViewController : UISearchBarDelegate {
//
//    func searchBarButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
////
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        if searchBar.text?.count == 0 {
//            loadItems()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//
//        }
//        else {
//
//        }
   
