//
//  StringExtensions.swift
//  EBKSampleApp
//
//  Created by Calo, Ignazio on 27/05/2016.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

import Foundation

extension String {

    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluateWithObject(self)
    }
}