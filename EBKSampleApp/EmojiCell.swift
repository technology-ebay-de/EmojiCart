//
//  EmojiCell.swift
//  EBKSampleApp
//
//  Created by Calo, Ignazio on 31/05/2016.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

import UIKit

enum ActionType {
    case Plus
    case Minus
}

typealias CompletionBlock = (action: ActionType) -> Void

class EmojiCell: UITableViewCell {

    var actionHandler :CompletionBlock?

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!


    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()

        self.plusButton.layer.cornerRadius = self.plusButton.bounds.size.width  / 2
        self.minusButton.layer.cornerRadius = self.minusButton.bounds.size.width  / 2
    }

    @IBAction func plusButtonTapped(sender: AnyObject) {
        self.actionHandler?(action: .Plus)
    }

    @IBAction func minusButtonTapped(sender: AnyObject) {
        self.actionHandler?(action: .Minus)
    }

}