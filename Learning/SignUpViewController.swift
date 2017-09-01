//
//  File.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-09.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Actions before view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Sign Up Action for email
    @IBAction func createAccountAction(_ sender: AnyObject) {
        
        // check to see if email field is blank or not
        if (emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty) {
            
            // alert popup to notify user to enter an email and/or password (add a title and msg)
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            // OK action to alert popup to *cancel* popup
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            // add action to the alert
            alertController.addAction(defaultAction)
            
            // present the alert
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            // create a new user now with the according email and password
            if isValidEmail(emailString: emailTextField.text!) {
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                // no error when signing in
                if error == nil {
                    print("You have successfully signed up")
                    
                    // present the notes for user
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Notes Nav")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    // show error if there was one when logging in
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
          }
            else {
                let alertController = UIAlertController(title: "Error", message: "Please enter a valid email", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // check for valid email
    func isValidEmail(emailString: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: emailString)
    }
    
    
}
