//
//  ViewController.swift
//  OIS Dashboard
//
//  Created by Jeremy Anderson on 24/05/2021.
//

import UIKit

class DashboardViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDayTypeForToday()
        let roomNumber = "325" // TODO: Change to a real value from the settings
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
        
    }
    
    /* Returns the class that is currently in this room*/
    func getCurrentClass(roomNumber: String) -> ClassBlock {
        // TODO: Implement
        // Hint, you have a function that can give you an array of all of today's classes...
        return ClassBlock(className: "test", teacherName: "test", startTime: NSDate(), endTime: NSDate(), blockName: "test")
    }
    
    /* Calculates and returns the time left before the bell rings for the current class */
    func timeLeftInClass() -> NSDate {
        // TODO: Implement
        // Hint, you have a function that can give you the current class...
        return NSDate()
    }
}

