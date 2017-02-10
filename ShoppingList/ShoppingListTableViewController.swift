//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Chance Robertson on 2/10/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, ItemTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.sharedController.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        
        let item = ItemController.sharedController.items[indexPath.row]
        
        cell.item = item
        cell.delegate = self
        
        return cell
    }
    
    func itemCellButtonTapped(sender: ItemTableViewCell) {
        guard let item = sender.item, let indexPath = tableView.indexPath(for: sender) else { return }
        
        ItemController.sharedController.toggleGotItemFor(item: item)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - UI Action
    
    @IBAction func addItemButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add an Item", message: "Enter the name of the item you want to add to your shopping list below!", preferredStyle: .alert)
        
        var itemNameTextField: UITextField?
        
        alertController.addTextField { (textField) in
            itemNameTextField = textField
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            
            guard let name = itemNameTextField?.text else { return }
            
            ItemController.sharedController.add(name: name)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let item = ItemController.sharedController.items[indexPath.row]
            
            ItemController.sharedController.delete(item: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
