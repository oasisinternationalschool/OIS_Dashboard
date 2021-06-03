//
//  ViewController.swift
//  OIS Dashboard
//
//  Created by Jeremy Anderson on 24/05/2021.
//

import UIKit
import Foundation

class DashboardViewController: UIViewController {

    var roomNumber = "325" // TODO: Change to a real value from the settings
    {
        didSet{
            // TODO: Update the UI
            // What else do we have to update?
        }
    }
    
    var dayType: DayType = .None
    {
        didSet{
            print("The day type is \(dayType)")
            // TODO: Update the UI
        }
    }
    
    var classBlocks: [ClassBlock] = []
    {
        didSet{
            // TODO: Update the UI
        }
    }
    
    func updateUI() {
        // TODO: Implement
        // How often should we call this function?
        // What labels should we set?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Date formatting sample code
        // Calling Date() returns the current time
        let currentDateAndTime = Date()
        // A date formatter turns Date objects or Strings into formatted strings
        let formatter = DateFormatter()
        // The 'dateFormat' represents how you want to present the Date in the new string
        // Use https://nsdateformatter.com/ to find what to put here
        formatter.dateFormat = "MM/dd/yyyy"
        // Use the formatter and the dateFormat from above to make a new formatted String
        let dateString = formatter.string(from: currentDateAndTime)
        print(dateString)

        
        //getDayTypeForToday()
        
        getClassBlocksForToday(roomNumber: roomNumber)
    }

    /* Uses a network call to the server to retrieve the day type of the current day */
    func getDayTypeForToday() {
        let urlPath = "/getDayType"
        // Create a URLRequest for an API endpoint
        let url = URL(string: "\(SERVER_URL)\(urlPath)")!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // Everything in this code block is called asynchronously at a 'later' time
            print("Started network call for the day type")
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    // Convert the string data into a JSON Object and then convert that JSON object into a Swift Dictionary
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                    if(json!["dayType"]! as! String == "A") {
                        self.dayType = .A
                    }
                    else if (json!["dayType"]! as! String == "O") {
                        self.dayType = .O
                    }
                    else{
                        self.dayType = .None
                    }
                } catch {
                   print("Something went wrong with the data.")
                }
            } else {
                print("The server responded, but did not send any data.")
            }
        }
        task.resume()
    }

    /* Uses a network call to the server to retrieve all classes that are taught in this room on the current day */
    func getClassBlocksForToday(roomNumber: String) {
        // TODO: Implement
        let urlPath = "/getBellScheduleForRoom"
        let url = URL(string: "\(SERVER_URL)\(urlPath)")!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // Everything in this code block is called asynchronously at a 'later' time
            print("Started network call for the class schedule")
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    // Convert the string data into a JSON Object and then convert that JSON object into a Swift Dictionary
                    let classArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [ [String:AnyObject] ]
                    for classDict in classArray {
                        print(classDict)
                        
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                        let startDate = dateFormatter.date(from: classDict["startTime"]! as! String)!
                        
                        
                        // Do the same thing for the end date
                        
                        
                        // Fill in this line
                        //classBlocks.append(ClassBlock(className: classDict["className"]!, teacherName: classDict["teacherName"]!, startTime: , endTime: , blockName: classDict["blockName"]!))
                    }
                  
                } catch {
                   print("Something went wrong with the data.")
                }
            } else {
                print("The server responded, but did not send any data.")
            }
        }
        task.resume()
        
    }
    
    /* Returns the class that is currently in this room*/
    func getCurrentClass(roomNumber: String) -> ClassBlock {
        // TODO: Implement
        // Hint, you have a function that can give you an array of all of today's classes...
        
        // Search through all the classes
        // Return the one that is now
        return ClassBlock(className: "Test-AP CS", teacherName: "Test-Mr. Anderson", startTime: Date(), endTime: Date(), blockName: "Test-B4(O)")
    }
    
    /* Calculates and returns the time left before the bell rings for the current class */
    func timeLeftInClass() -> Date {
        // TODO: Implement
        // Hint, you have a function that can give you the current class...
        return Date()
    }
}

