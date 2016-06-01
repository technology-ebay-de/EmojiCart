//
//  ShoppingList.swift
//  EBKSampleApp
//
//  Created by Calo, Ignazio on 31/05/2016.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

import UIKit

typealias Emoji = (symbol: String, name: String)

class ShoppingListViewController : UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    private var unfilteredEmojiDB: [Emoji] = []
    private var emojiDB: [Emoji] = []

    private var cart: [Emoji] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        self.searchBar.accessibilityTraits = UIAccessibilityTraitSearchField
        self.searchBar.isAccessibilityElement = true
        self.searchBar.accessibilityLabel = "searchbar"
        self.searchBar.accessibilityElementsHidden = false
        self.tableView.accessibilityIdentifier = "EmojiList"
        emojiDB = loadEmojiDatabase()
        unfilteredEmojiDB = loadEmojiDatabase()
        self.title = "Catalog"
    }
}

extension ShoppingListViewController {

    func loadEmojiDatabase() -> [Emoji] {
        let path = NSBundle.mainBundle().pathForResource("emoji", ofType: "csv")
        let contentOfFile = try! String(contentsOfFile: path!)
        let rows = contentOfFile.componentsSeparatedByString("\n")

        let db: [Emoji] = rows.map { (row) -> Emoji in
            let row_part = row.componentsSeparatedByString(";")
            return Emoji(row_part.first!, row_part.last!)
        }

        return db
    }


    @IBAction func buyButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("show_cart", sender: nil)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cartViewController = segue.destinationViewController as! CartViewController
        cartViewController.cart = cart
    }
}

extension ShoppingListViewController : UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            self.emojiDB = self.unfilteredEmojiDB.filter({ $0.name.rangeOfString(searchText.lowercaseString) != nil })
        } else {
            self.emojiDB = self.unfilteredEmojiDB
        }

        self.tableView.reloadData()
    }
}


extension ShoppingListViewController : UITableViewDelegate {

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}

extension ShoppingListViewController : UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emojiDB.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :EmojiCell = tableView.dequeueReusableCellWithIdentifier("EmojiCell", forIndexPath: indexPath) as! EmojiCell

        let emoji = emojiDB[indexPath.row]
        cell.emojiLabel.text = emoji.symbol
        cell.descriptionLabel.text = emoji.name
        cell.accessibilityLabel = emoji.name

        cell.actionHandler = { action in
            switch action {
            case .Plus:
                self.cart.append(emoji)
            case .Minus:
                let index = self.cart.indexOf({ $0.symbol == emoji.symbol})
                if let index = index {
                    self.cart.removeAtIndex(index)
                }
            }

            UIView.animateWithDuration(1, animations: { [unowned self] in
                self.bottomConstraint.constant = (self.cart.count > 0) ? 0 : -80
                self.view.setNeedsLayout()
                })

            self.ctaButton.setTitle("Buy \(self.cart.count) emoji ", forState: .Normal)
            self.ctaButton.accessibilityLabel = "Buy \(self.cart.count) emoji "
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let emoji = emojiDB[indexPath.row]

        self.cart.append(emoji)
        UIView.animateWithDuration(1, animations: { [unowned self] in
            self.bottomConstraint.constant = (self.cart.count > 0) ? 0 : -80
            self.view.setNeedsLayout()
            })

        self.ctaButton.setTitle("Buy \(self.cart.count) emoji ", forState: .Normal)
        self.ctaButton.accessibilityLabel = "Buy \(self.cart.count) emoji "
    }
    
}