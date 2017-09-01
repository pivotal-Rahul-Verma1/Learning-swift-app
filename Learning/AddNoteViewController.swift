//
//  AddNoteViewController.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-10.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var noteField: UITextView!
    var ref = Database.database().reference(withPath: "sample-item")
    
    var note: Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        titleField.layer.borderWidth = 1.0
        noteField.layer.borderWidth = 1.0
        
        
        if let note = note {
            self.title = "Edit Note"
            
            titleField.text = note.title
            noteField.text = note.notes
        } else {
            title = "New Note"
        }
    }
    
    
//    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        if(titleField.text!.isEmpty || noteField.text.isEmpty) {
            showAlert( "Error", message: "Note is incomplete", buttonTitle: "Ok")
            return
        }
        
        if( currentUser != nil ) {
            ref = Database.database().reference(withPath: currentUser.uid)
        }
        
        if let note = note {
            note.title = titleField.text!
            note.date = formatter.string(from: Date())
            note.notes = noteField.text!
            note.email = currentUser.email
            let notesItemRef = self.ref.child(note.title.lowercased())
            notesItemRef.setValue(note.toAnyObject())
        } else {
            let uuid = UUID().uuidString
            note = Notes(id: uuid, title: titleField.text!, notes: noteField.text!, date: formatter.string(from: Date()),email: currentUser.email)
            let notesItemRef = self.ref.child(titleField.text!.lowercased())
            notesItemRef.setValue(note!.toAnyObject())
//            notes.append(note!)
        }
        
    let _ = navigationController?.popViewController(animated: true)
         // self.dismiss(animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    fileprivate func showAlert(_ title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

/*
 guard let note
 */
