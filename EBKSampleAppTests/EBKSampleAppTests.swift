//
//  EBKSampleAppTests.swift
//  EBKSampleAppTests
//
//  Created by Calo, Ignazio on 19/05/2016.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

@testable import EBKSampleApp

class EBKSampleAppTests: EBKUnitTest {
    
    func testLoginFlow() {
        self.deviceAgnostic = true
        // self.recordMode = true

        KIFTestActor.setDefaultTimeout(10)

        snapshotVerifyView(self.rootViewController().view, withIdentifier: "initial_state")

        logIn()

        addTwoWhalesToTheCart()
        addKentBeckEmojiToTheCart()
        addSunglassToTheCart()

        validateOrderPage()

        testerActor().waitForTimeInterval(5)

    }


    func logIn() {
        testerActor().clearTextFromViewWithAccessibilityIdentifier("login_username_field")
        testerActor().enterText("demo@example.com", intoViewWithAccessibilityIdentifier: "login_username_field")
        testerActor().enterText("demo", intoViewWithAccessibilityIdentifier: "login_password_field")
        testerActor().tapViewWithAccessibilityLabel("login_btn")
        testerActor().waitForViewWithAccessibilityLabel("grinning face")
        snapshotVerifyView(self.rootViewController().view, withIdentifier: "list_of_products")
    }

    func addTwoWhalesToTheCart(){
        //Search for the Whale emoji
        testerActor().clearTextFromViewWithAccessibilityLabel("searchbar")
        testerActor().enterText("Whale", intoViewWithAccessibilityLabel: "searchbar")

        //Add a whale to the cart
        testerActor().tapRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), inTableViewWithAccessibilityIdentifier: "EmojiList")
        testerActor().tapRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), inTableViewWithAccessibilityIdentifier: "EmojiList")

        snapshotVerifyView(self.rootViewController().view, withIdentifier: "two_whales_into_the_cart")
    }

    func addKentBeckEmojiToTheCart() {

        //Search for the Kent Beck emoji
        testerActor().clearTextFromViewWithAccessibilityLabel("searchbar")
        testerActor().enterText("good gesture", intoViewWithAccessibilityLabel: "searchbar")
        testerActor().tapRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), inTableViewWithAccessibilityIdentifier: "EmojiList")

        snapshotVerifyView(self.rootViewController().view, withIdentifier: "3_item_into_the_cart")

    }

    func addSunglassToTheCart()  {
        //Search a sunglass
        testerActor().clearTextFromViewWithAccessibilityLabel("searchbar")
        testerActor().enterText("Sunglasses", intoViewWithAccessibilityLabel: "searchbar")
        testerActor().tapRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), inTableViewWithAccessibilityIdentifier: "EmojiList")

        snapshotVerifyView(self.rootViewController().view, withIdentifier: "4_item_into_the_cart")
    }

    func validateOrderPage() {
        //Go to the cart
        testerActor().tapViewWithAccessibilityLabel("Buy 4 emoji ")
        testerActor().waitForViewWithAccessibilityLabel(" 🐳  🐳  🙅  😎 ")

        //Take a screenshot of the cart
        snapshotVerifyView(self.rootViewController().view, withIdentifier: "final_cart")
    }


}
