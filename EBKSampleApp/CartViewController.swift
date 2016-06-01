//
//  ChartViewController.swift
//  EBKSampleApp
//
//  Created by Calo, Ignazio on 31/05/2016.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

import UIKit
class CartViewController: UIViewController {
    var cart :[Emoji] = []

    @IBOutlet weak var textLabel: UILabel!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let result = cart.reduce("", combine: { $0 + " \($1.symbol) " })
        self.textLabel.text = result
        self.textLabel.accessibilityLabel = self.textLabel.text
    }
}