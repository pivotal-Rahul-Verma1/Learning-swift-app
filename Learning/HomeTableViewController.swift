//
//  HomeTableViewController.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-04.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import Foundation

import UIKit

class HomeTableViewController: UITableViewController {
    
    var funcCells = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEachFunc()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funcCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HomeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell else {
            fatalError("The dequeued cell is not an instance of HomeTableViewCell")
        }
        
        let function = funcCells[indexPath.row]
        cell.homeLabel.text = function
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "MFR", sender: self)
            break
        case 1:
            self.performSegue(withIdentifier: "War", sender: self)
            break
        case 2:
            self.performSegue(withIdentifier: "Login", sender: self)
            break
        default:
            break
        }
    }
    
    
    private func loadEachFunc() {
        funcCells += ["Filter, Reduce, and Map", "War", "NoteKeeper"]
    }
}
