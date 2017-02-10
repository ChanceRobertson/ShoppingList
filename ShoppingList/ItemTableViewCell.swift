//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Chance Robertson on 2/10/17.
//  Copyright © 2017 Chance Robertson. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    weak var delegate: ItemTableViewCellDelegate?
    
    var item: Item? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let item = item else { nameLabel.text = ""; return }
        
        nameLabel.text = item.name
        let image = item.gotItem ? #imageLiteral(resourceName: "complete") : #imageLiteral(resourceName: "incomplete")
        
        checkboxButton.setImage(image, for: .normal)
    }
    
    // MARK: - UI Actions
    
    @IBAction func checkboxButtonTapped(_ sender: Any) {
        delegate?.itemCellButtonTapped(sender: self)
    }
}

protocol ItemTableViewCellDelegate: class {
    func itemCellButtonTapped(sender: ItemTableViewCell)
}
