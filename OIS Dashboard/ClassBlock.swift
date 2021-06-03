//
//  ClassBlock.swift
//  OIS Dashboard
//
//  Created by Jeremy Anderson on 24/05/2021.
//

import Foundation

class ClassBlock {
    var className: String
    var teacherName: String
    var startTime: NSDate
    var endTime: NSDate
    var blockName: String
    
    init(className: String, teacherName: String, startTime: NSDate, endTime: NSDate, blockName: String) {
        self.className = className
        self.teacherName = teacherName
        self.startTime = startTime
        self.endTime = endTime
        self.blockName = blockName
    }
}
