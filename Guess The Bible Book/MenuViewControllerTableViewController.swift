//
//  MenuViewControllerTableViewController.swift
//  Guess The Bible Book
//
//  Created by Abigail Farrand on 01/08/2015.
//  Copyright (c) 2015 Far End Designs. All rights reserved.
//

import UIKit

class MenuViewControllerTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath) as? UITableViewCell
        
        cell!.textLabel?.text = "Hello"
        return cell!
    }

   
}
