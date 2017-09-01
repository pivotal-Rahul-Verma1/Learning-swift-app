//
//  LearningNKEarlGreyTests.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-17.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import XCTest
import EarlGrey
import Firebase

@testable import Learning

class LearningNKEarlGreyTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Learning_Cell")).atIndex(UInt(2))
            .perform(grey_tap())
        // Called once before all tests are run
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_A_assertLoginVisibility() {
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Login Header"))
            .assert(grey_sufficientlyVisible())
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Login Email"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Login Password"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Login Button"))
            .assert(grey_sufficientlyVisible())
        
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Signup Button"), grey_buttonTitle("Signup")]))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Reset Button"),
            grey_buttonTitle("Reset Password")]))
                .assert(grey_sufficientlyVisible())
    }
    
    func test_B_signUpVisibility() {
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Signup Button"), grey_sufficientlyVisible()]))
                .perform(grey_tap())
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Signup Header"))
            .assert(grey_sufficientlyVisible())
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Signup Email"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Signup Password"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Signup Button"))
            .assert(grey_sufficientlyVisible())
        
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Login Button"), grey_buttonTitle("Login")]))
                .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Reset Button"),
            grey_buttonTitle("Reset Password")]))
                .assert(grey_sufficientlyVisible())

    }
    
    func test_C_signUp() {
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Signup Email"))
            .perform(grey_typeText("rahul.j.verma@gmail.com"))
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Signup Password"))
            .perform(grey_typeText("xtremer1"))
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Signup Button"))
            .perform(grey_tap())
    }
    
    func test_D_assertAddNoteVisibility() {
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Add"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_text("Notes"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_text("No Notes Currently Noted"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_buttonTitle("Logout"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_buttonTitle("Delete"))
            .assert(grey_sufficientlyVisible())
    }
    
    func test_E_addANote() {
        EarlGrey.select(elementWithMatcher: grey_accessibilityLabel("Add"))
            .perform(grey_tap())
        
    }
    
    
    
    func test_E_delete() {
        EarlGrey.select(elementWithMatcher: grey_buttonTitle("Delete"))
            .perform(grey_tap())
    }
    
    
    
}
