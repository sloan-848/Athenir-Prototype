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
    
    var queryResults: [ATResult] = []
    
    var queryString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // queue network request
        let requestURL = "http://athenir.com/api/search?query=\(queryString)&type=web"
        let encodedURL = requestURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        Alamofire.request(.GET, encodedURL)
            .responseJSON { request, response, data, error in
                //Create swiftyJSON object
                let decoded = JSON(data!)
                
                if (decoded["success"]){
                    var tempResults: [ATResult] = []
                    let dataArray = decoded["data"]
                    
                    // fill array
                    for i in 0...dataArray.count - 1 {
                        let member = ATResult()
                        member.title = dataArray[i]["title"].string!
                        member.url = dataArray[i]["url"].string!
                        member.snippet = dataArray[i]["snippet"].string!
                        
                        tempResults.append(member)
                    }
                    self.queryResults = tempResults
                    self.tableView.reloadData()
                } else {
                    // error with request, promptly catch on fire
                }
        }
        
        // set initial element of array
        let filler: ATResult = ATResult()
        filler.title = "Loading..."
        queryResults.append(filler)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queryResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultItem") as UITableViewCell!
        
        let title = cell.viewWithTag(1000) as! UILabel
        let description = cell.viewWithTag(1001) as! UILabel
        
        // Included to negate out of bounds error
        if (indexPath.item < queryResults.count) {
            title.text = queryResults[indexPath.item].title
            description.text = queryResults[indexPath.item].snippet
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var rowHeight: CGFloat = 80
        rowHeight += CGFloat(queryResults[indexPath.item].snippet.characters.count / 80) * 40.0
        
        return rowHeight
    }
    
}
