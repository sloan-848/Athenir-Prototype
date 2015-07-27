//
//  ResultsViewController.swift
//  athenir_prototype
//
//  Created by Will Sloan on 7/24/15.
//  Copyright © 2015 848 Applications and Designs. All rights reserved.
//

import UIKit
import Alamofire

class ResultsViewController: UITableViewController {
    
    var results: [String] = ["The Cow Jumped", "Hello World", "My Fair Lady", "Many", "Other", "Items"]
    
    var queryString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // send network request
        let requestURL = "http://athenir.com/api/search?query=\(queryString)&type=web"
        let encodedURL = requestURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        /*let finalURL = NSURL(string: encodedURL)!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(finalURL) {(data, response, error) in
            if (error != nil){
                //explode in flames
            } else {
                let responseJSON = JSON(data: data!)
                if (!responseJSON["success"]){
                    //only burn a bit
                } else {
                    //insert data into model
                    //update 
                    
                }
          }
        }
        
        task.resume()*/
        Alamofire.request(.GET, encodedURL)
            .responseJSON { request, response, data, error in
                //Create swiftyJSON object
                let decoded = JSON(data!)
                
                print(decoded)
        }
        
        print("Recieved message \(queryString)")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultItem") as UITableViewCell!
        
        let title = cell.viewWithTag(1000) as! UILabel
        let description = cell.viewWithTag(1001) as! UILabel
        
        title.text = queryString
        description.text = results[indexPath.item]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var rowHeight: CGFloat = 80
        rowHeight += CGFloat(results[indexPath.item].characters.count / 80) * 40.0
        
        return rowHeight
    }
    
}
