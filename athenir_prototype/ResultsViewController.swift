//
//  ResultsViewController.swift
//  athenir_prototype
//
//  Created by Will Sloan on 7/24/15.
//  Copyright © 2015 848 Applications and Designs. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {
    
    var results: [String] = ["The Cow Jumped", "Hello World", "My Fair Lady"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultItem") as UITableViewCell!
        
        let title = cell.viewWithTag(1000) as! UILabel
        let description = cell.viewWithTag(1001) as! UILabel
        
        title.text = "New Title"
        description.text = results[indexPath.item]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var rowHeight: CGFloat = 80
        rowHeight += CGFloat(results[indexPath.item].characters.count / 80) * 40.0
        
        return rowHeight
    }
    
}
