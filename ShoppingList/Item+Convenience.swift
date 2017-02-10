//
//  Item+Convenience.swift
//  ShoppingList
//
//  Created by Chance Robertson on 2/10/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    @discardableResult convenience init(name: String, gotItem: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.gotItem = gotItem
    }
}
