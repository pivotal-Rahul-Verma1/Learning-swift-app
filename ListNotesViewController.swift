//
//  LogOut.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-09.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import UIKit
import Firebase

var notes: [Notes] = []
var currentUser: User!

class ListNotesViewController: UIViewController {

    @IBOutlet weak var notesTableView: UITableView!
    var ref = Database.database().reference(withPath: "sample-items")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        Auth.auth().addStateDidChangeListener { auth, user in

            guard let user = user else { return }
            
            currentUser = User(uid: user.uid, email: user.email!)
            self.ref = Database.database().reference(withPath: currentUser.uid)
            self.ref.observe(.value, with: { snapshot in

                var newItems: [Notes] = []

                for item in snapshot.children {
                    let note = Notes(snapshot: item as! DataSnapshot)
                    newItems.append(note)
                }
                
                notes = newItems
                self.notesTableView.reloadData()
            })
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesTableView.reloadData()
    }
    
    func setMessageLabel(_ messageLabel: UILabel, frame: CGRect, text: String, textColor: UIColor, numberOfLines: Int, textAlignment: NSTextAlignment, font: UIFont) {
        messageLabel.frame = frame
        messageLabel.text = text
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = numberOfLines
        messageLabel.textAlignment = textAlignment
        messageLabel.font = font
        messageLabel.sizeToFit()
    }
    
    // change?
    func setCellWithNoteItem(_ cell: UITableViewCell, note: Notes) {
        let titleLabel: UILabel = cell.viewWithTag(2) as! UILabel
        let dateLabel: UILabel = cell.viewWithTag(3) as! UILabel
        
        titleLabel.text = note.title
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM-dd-yyyy"
        dateLabel.text = note.date
    }
    
    // do not change
    @IBAction func logOutAction(sender: AnyObject) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                 let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home Nav")
                 present(vc, animated: true, completion: nil)
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func deleteUser(sender: AnyObject) {
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                if let error = error {
                    // An error happened.
                    print(error.localizedDescription)
                } else {
                    // Account deleted.
                    let userData = Database.database().reference(withPath: currentUser.uid)
                    userData.removeValue()
                    
                    do {
                    try Auth.auth().signOut()
                    
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home Nav")
                    self.present(vc, animated: true, completion: nil)
                    
                    }
                    catch let error as NSError {
                    print(error.localizedDescription)
                }
                }
            }
        }
    }
    
    // do not change
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote" {
            let vc = segue.destination as! AddNoteViewController
            let indexPath = notesTableView.indexPathForSelectedRow
            if let indexPath = indexPath {
                vc.note = notes[(indexPath as NSIndexPath).row]
            }
        }
    }
}

extension ListNotesViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if notes.count != 0 {
//            print(self.notesTableView.backgroundView)
            self.notesTableView.backgroundView = nil
            return notes.count
        } else {
            let messageLabel: UILabel = UILabel()
            
            setMessageLabel(messageLabel, frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), text: "No Notes Currently Noted", textColor: UIColor.black, numberOfLines: 0, textAlignment: NSTextAlignment.center, font: UIFont(name:"HelveticaNeue-UltraLight", size: 20)!)
            self.notesTableView.backgroundView = messageLabel
            self.notesTableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "notesCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        setCellWithNoteItem(cell, note: notes[(indexPath as NSIndexPath).row])
        
        return cell
    }
}

extension ListNotesViewController: UITableViewDelegate {
    
    // Edit mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        notesTableView.setEditing(editing, animated: true)
    }
    
    // Delete the cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let noteItem = notes[indexPath.row]
            noteItem.ref?.removeValue()
            notes.remove(at: (indexPath as NSIndexPath).row)
            notesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    // Move the cell
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let note = notes.remove(at: (sourceIndexPath as NSIndexPath).row)
        notes.insert(note, at: (destinationIndexPath as NSIndexPath).row)
    }
}
