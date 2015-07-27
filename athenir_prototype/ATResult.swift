//
//  ATResult.swift
//  athenir_prototype
//
//  Created by Will Sloan on 7/26/15.
//  Copyright © 2015 848 Applications and Designs. All rights reserved.
//

import Foundation

class ATResult: NSObject {
    var title: String = ""
    var url: String = ""
    var snippet: String = ""
    
    func stringValue() -> String {
        return "\(title): \(url), \(snippet)"
    }
}