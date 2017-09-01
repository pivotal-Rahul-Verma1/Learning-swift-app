//
//  File.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-04.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import Foundation

import UIKit
import Social

class MFRViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mvrTitle: UILabel!
    @IBOutlet weak var mvrField: UITextField!
    @IBOutlet weak var filterAmount: UITextField!
    @IBOutlet weak var reduceField: UITextField!
    @IBOutlet weak var mapField: UITextField!
    @IBOutlet weak var filterField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var reduceButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var reduceSeg: UISegmentedControl!
    @IBOutlet weak var mapSeg: UISegmentedControl!
    
    var numArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterAmount.text = "0"
        
        mvrTitle.text = "Filter, Calc, & Reduce"
        
        // arrayTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @IBAction func reduceButton(_ sender: UIButton) {
        
        checkAndConvertValidArray()
        
        var result: Int
        
        switch reduceSeg.selectedSegmentIndex {
        
        case 0:
            result = numArray.reduce(0,+)
            break
        case 1:
            result = numArray.reduce(numArray[0]*2) {$0-$1}
            break
        case 2:
            result = numArray.reduce(1){$0 * $1}
            break
        default:
            result = 0
            break
        }
        
        reduceField.text = ("\(result)")
    }
    
    @IBAction func filterButton(_ sender: UIButton) {
        var filterLimit: String!
        
        filterLimit = filterAmount.text!
        
        if(filterLimit.isEmpty || Int(filterLimit) == nil ) {
            showAlert( "Error", message: "Enter a proper filter limit", buttonTitle: "Ok")
            return
        }
        
        checkAndConvertValidArray()
        
        var result: String
        
        let filterValue = Int(filterAmount.text!)
        result = numArray.filter{ $0 > filterValue! }.description
        
        result = result.replacingOccurrences(of: "[\\[\\]]", with: "", options: .regularExpression)
        
        filterField.text = (result)
    }
    
    @IBAction func mapButton(_ sender: UIButton) {
        
        checkAndConvertValidArray()
        
        var moneyArray: [String] = []
        
        switch mapSeg.selectedSegmentIndex {
        
        case 0:
            moneyArray = numArray.map({"$\($0)"})
            break
        case 1:
            moneyArray = numArray.map({"€\($0)"})
            break
        default:
            break
        }
        
        let result = moneyArray.description.replacingOccurrences(of: "[\\[\\]]", with: "", options: .regularExpression)
        mapField.text = result.replacingOccurrences(of: "\"", with: "", options: .regularExpression)
    }
    
    
    func parseCommaSeperatedNumber  (string: String) throws -> [Int]   {
    

        var stringArray = string
        stringArray = stringArray.replacingOccurrences(of: ",", with: " ")
        stringArray = stringArray.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)

        let intArray = stringArray.components(separatedBy: " ")

        let readyInts = try intArray.map {
            (int:String)->Int in
            guard Int(int) != nil else {
                throw NSError.init(domain: " \(int) is not digit", code: -99, userInfo: nil)
            }
            return Int(int)!
        }

        return readyInts
    }
    
    fileprivate func showAlert(_ title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func checkAndConvertValidArray() {
        var numList: String!

        numList = mvrField.text!
        
        if(numList == nil || numList.isEmpty) {
            showAlert( "Error", message: "Need a list of numbers", buttonTitle: "Ok")
            return
        }
        
        do {
            numArray = try parseCommaSeperatedNumber(string: numList)
        } catch let error as NSError {
            print(error)
            showAlert( "Error", message: "Need a list of numbers", buttonTitle: "Ok")
        }
    }
    
}
