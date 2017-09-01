//
//  LearningEarlGreyTests.swift
//  LearningEarlGreyTests
//
//  Created by Pivotal DX218 on 2017-08-08.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import XCTest
import EarlGrey
import Firebase

@testable import Learning

class LearningEarlGreyTests: XCTestCase {
    
    open class Element {
        var text =  ""
    }
    
//    override func setUp() {
//        super.setUp()
//        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Learning_Cell")).atIndex(UInt(0))
//            .perform(grey_tap())
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
    
    override class func setUp() {
        super.setUp()
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Learning_Cell")).atIndex(UInt(0))
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
    
    func test_A_assertMFR() {
        // EarlGrey.select(elementWithMatcher: grey_ )
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("MFR_Label"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("MFR_Field"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Button"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Amount"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Field"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Reduce_Button"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Reduce_Field"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Map_Button"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Map_Field"))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Calculate_Button"))
            .assert(grey_sufficientlyVisible())
    }
    
    func test_B_filter() {
        enterMFRField(arrayString: "30, 50, 60, 70, 80")
        tapMFRButton(buttonString: "filter")
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Filter_Field"), grey_text("30, 50, 60, 70, 80")]))
            .assert(grey_sufficientlyVisible())
        
        enterMFRField(arrayString: "30, 50,        60, 70, 80")
        tapMFRButton(buttonString: "filter")
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Filter_Field"), grey_text("30, 50, 60, 70, 80")]))
            .assert(grey_sufficientlyVisible())
        
        enterMFRField(arrayString: "30 50, 60,    70 80")
        tapMFRButton(buttonString: "filter")
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Filter_Field"), grey_text("30, 50, 60, 70, 80")]))
            .assert(grey_sufficientlyVisible())
    }
    
    func test_C_filterWithLimit() {
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Amount"))
            .perform(grey_replaceText("50"))
        tapMFRButton(buttonString: "filter")
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Filter_Field"), grey_text("60, 70, 80")]))
            .assert(grey_sufficientlyVisible())
    }
    
    func test_D_filterWithInvalidLimit() {
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Amount"))
            .perform(grey_replaceText("word"))
        tapMFRButton(buttonString: "filter")
        assertError(errorTitle: "Error", errorDeets: "Enter a proper filter limit")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Amount"))
            .perform(grey_replaceText(""))
        tapMFRButton(buttonString: "filter")
        assertError(errorTitle: "Error", errorDeets: "Enter a proper filter limit")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())
        
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Amount"))
            .perform(grey_replaceText("50"))
    }
    
    func test_E_filterWithInvalidArray() {
        enterMFRField(arrayString: "")
        tapMFRButton(buttonString: "filter")
        assertError(errorTitle: "Error", errorDeets: "Need a list of numbers")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())
        
        enterMFRField(arrayString: "5, 10, word, 16")
        tapMFRButton(buttonString: "filter")
        assertError(errorTitle: "Error", errorDeets: "Need a list of numbers")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())

    }
    
    func test_F_reduce() {
        enterMFRField(arrayString: "5, 6, -10, 4, 5")
        tapMFRButton(buttonString: "reduce")
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Reduce_Field"), grey_text("10")]))
            .assert(grey_sufficientlyVisible())
        
        EarlGrey.select(elementWithMatcher: grey_text("-"))
            .perform(grey_tap())
        tapMFRButton(buttonString: "reduce")
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Reduce_Field"), grey_text("0")]))
            .assert(grey_sufficientlyVisible())
        
        EarlGrey.select(elementWithMatcher: grey_text("x"))
            .perform(grey_tap())
        tapMFRButton(buttonString: "reduce")
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Reduce_Field"), grey_text("-6000")]))
            .assert(grey_sufficientlyVisible())
    }
    
    func test_G_reduceWithInvalidArray() {
        enterMFRField(arrayString: "")
        tapMFRButton(buttonString: "reduce")
        assertError(errorTitle: "Error", errorDeets: "Need a list of numbers")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())
        
        enterMFRField(arrayString: "5, 6, negative, 4, 5")
        tapMFRButton(buttonString: "reduce")
        assertError(errorTitle: "Error", errorDeets: "Need a list of numbers")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())
    }
    
    func test_H_map() {
        enterMFRField(arrayString: "5, 10, 12, 50")
        tapMFRButton(buttonString: "map")
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Map_Field"), grey_text("$5, $10, $12, $50")]))
            .assert(grey_sufficientlyVisible())
        
        EarlGrey.select(elementWithMatcher: grey_text("€"))
            .perform(grey_tap())
        tapMFRButton(buttonString: "map")
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Map_Field"), grey_text("€5, €10, €12, €50")]))
            .assert(grey_sufficientlyVisible())
    }
    
    func test_I_mapWithInvalidArray() {
        enterMFRField(arrayString: "")
        tapMFRButton(buttonString: "map")
        assertError(errorTitle: "Error", errorDeets: "Need a list of numbers")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())
        
        enterMFRField(arrayString: "5, 6, negative, 4, 5")
        tapMFRButton(buttonString: "map")
        assertError(errorTitle: "Error", errorDeets: "Need a list of numbers")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())
    }
    
    func test_J_calculate() {
        enterMFRField(arrayString: "5, -10, -20, 10, 12, 50")
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Amount"))
            .perform(grey_replaceText("-5"))
        EarlGrey.select(elementWithMatcher: grey_text("+"))
            .perform(grey_tap())
        EarlGrey.select(elementWithMatcher: grey_text("€"))
            .perform(grey_tap())
        
        tapMFRButton(buttonString: "calculate")
        
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Filter_Field"), grey_text("5, 10, 12, 50")]))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Reduce_Field"), grey_text("47")]))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_allOf([grey_accessibilityID("Map_Field"), grey_text("€5, €-10, €-20, €10, €12, €50")]))
            .assert(grey_sufficientlyVisible())
        

    }
    
    func test_K_calculateWithInvalidArray() {
        enterMFRField(arrayString: "")
        tapMFRButton(buttonString: "calculate")
        assertError(errorTitle: "Error", errorDeets: "Need a list of numbers")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())
        
        enterMFRField(arrayString: "5, 6, negative, 4, 5")
        tapMFRButton(buttonString: "calculate")
        assertError(errorTitle: "Error", errorDeets: "Need a list of numbers")
        EarlGrey.select(elementWithMatcher: grey_text("Ok"))
            .perform(grey_tap())
    }
    
//    func test_C_eh () {
//        let element = Element()
//        EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Field")).perform(grey_getText(element))
//        print(element.self.text)
//        
//        
//    }
    
    func enterMFRField(arrayString: String) {
        EarlGrey.select(elementWithMatcher: grey_accessibilityID("MFR_Field"))
            .perform(grey_replaceText(arrayString))
    }
    
    func tapMFRButton(buttonString: String) {
        switch buttonString {
            case "filter":
                EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Button"))
                    .perform(grey_tap())
            case "reduce":
                EarlGrey.select(elementWithMatcher: grey_accessibilityID("Reduce_Button"))
                    .perform(grey_tap())
            case "map":
                EarlGrey.select(elementWithMatcher: grey_accessibilityID("Map_Button"))
                    .perform(grey_tap())
            case "calculate":
                EarlGrey.select(elementWithMatcher: grey_accessibilityID("Calculate_Button"))
                    .perform(grey_tap())
            default:
                EarlGrey.select(elementWithMatcher: grey_accessibilityID("Calculate_Button"))
                    .perform(grey_tap())
            
        }
    }
    
    func assertError(errorTitle: String, errorDeets: String) {
        EarlGrey.select(elementWithMatcher: grey_text(errorTitle))
            .assert(grey_sufficientlyVisible())
        EarlGrey.select(elementWithMatcher: grey_text(errorDeets))
            .assert(grey_sufficientlyVisible())
    }
    
//    func getTextField(field: String) -> String {
//        
//        //EarlGrey.select(elementWithMatcher: grey_accessibilityID("Filter_Field"))
//        EarlGrey.select(elementWithMatcher: )
//        return field
//    }
//    func grey_getText(_ elementCopy: Element) -> GREYActionBlock {
//        
//        return GREYActionBlock.action(withName: "get text", constraints: grey_respondsToSelector(#selector(getter: UITextField.text))) { element, errorOrNil -> Bool in
//            
//            let elementObject = element as? NSObject
//            let text = elementObject?.perform(#selector(getter: UITextField.text), with: nil)?.takeRetainedValue() as? String
//            elementCopy.text = text!
//            print(elementCopy.text)
//            return true
//        }}
}
