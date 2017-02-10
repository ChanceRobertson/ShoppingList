//
//  ItemController.swift
//  ShoppingList
//
//  Created by Chance Robertson on 2/10/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    static let sharedController = ItemController()
    
    // MARK: - Create
    
    func add(name: String) {
        let _ = Item(name: name)
        saveToPersistentStore()
    }
    
    // MARK: - Read
    
    var items: [Item] {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let moc = CoreDataStack.context
        
        do {
            return try moc.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - Update
    
    func toggleGotItemFor(item: Item) {
        item.gotItem = !item.gotItem
        saveToPersistentStore()
    }
    
    // MARK: - Delete
    
    func delete(item: Item) {
        let moc = CoreDataStack.context
        
        moc.delete(item)
        saveToPersistentStore()
    }
    
    // MARK: - Save
    
    func saveToPersistentStore() {
        
        let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch {
            NSLog("Could not save to managed object context.")
        }
    }
}
