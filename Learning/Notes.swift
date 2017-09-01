//
//  Notes.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-10.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import Foundation
import Firebase

class Notes: NSObject {
    let key: String
    var id: String
    var title: String
    var notes: String
    var date: String
    var email: String
    let ref: DatabaseReference?
    
    init(id: String, title: String, notes: String, date: String, email: String, key: String = "") {
        self.key = key
        self.id = id
        self.title = title
        self.notes = notes
        self.date = date
        self.email = email
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        id = snapshotValue["id"] as! String
        title = snapshotValue["title"] as! String
        notes = snapshotValue["notes"] as! String
        date = snapshotValue["date"] as! String
        email = snapshotValue["email"] as! String
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx"
//        date = dateFormatter.date(from: dateString)!
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM-dd-yyyy"
        return [
            "id": id,
            "title": title,
            "notes": notes,
            "date": date, //formatter.string(from: date)
            "email": email
        ]
    }
}
