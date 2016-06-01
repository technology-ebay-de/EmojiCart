//
//  ViewController.swift
//  EBKSampleApp
//
//  Created by Calo, Ignazio on 19/05/2016.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

import UIKit
import Chameleon


class ViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
    }

    @IBAction func loginBtnDidTap() {
        let input :String? = self.loginField.text
        guard let username = input else { return }

        if username.isValidEmail() {
            self.performSegueWithIdentifier("show_product_list", sender: nil)
        } else {
        }
    }
}

