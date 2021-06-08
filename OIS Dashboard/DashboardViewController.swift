//
//  ViewController.swift
//  OIS Dashboard
//
//  Created by Jeremy Anderson on 24/05/2021.
//

import UIKit
import Foundation

class DashboardViewController: UIViewController {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var classStartButton: UIButton!
    @IBOutlet weak var ODay: UILabel!
    
    @IBOutlet weak var ADay: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var classroonNumber: UILabel!
    
    var roomNumber = "325" // TODO: Change to a real value from the settings
    {
        didSet{
            // TODO: Update the UI
            // What else do we have to update? Or reset?
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
            print("There are  \(classBlocks.count) classes today.")
            // TODO: Update the UI
            if let curClass = getCurrentClass() {
                print("The current class is: \(curClass.className)")
            }
            else {
                print("No classes currently in session.")
            }
        }
    }
    
    func updateUI() {
        // How often should we call this function?
        // What labels should we set?
        
        // SET DATE AND TIME DISPLAY
        // Calling Date() returns the current time
        let currentDateAndTime = Date()
        // A date formatter turns Date objects or Strings into formatted strings
        let formatter = DateFormatter()
        // The 'dateFormat' represents how you want to present the Date in the new string
        // Use https://nsdateformatter.com/ to find what to put here
        formatter.dateFormat = "MMM/dd/yyyy"

        // Use the formatter and the dateFormat from above to make a new formatted String
        let dateString = formatter.string(from: currentDateAndTime)
        print(dateString)
        date.text = dateString
        
        //print out time 62 64 66 for time
        formatter.dateFormat = "hh: mm : ss a"
        let timeString = formatter.string(from: currentDateAndTime)
        print(timeString)
        time.text = timeString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDayTypeForToday()
        getClassBlocksForToday(roomNumber: roomNumber)
        
        updateUI()
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
        let urlPath = "/getBellScheduleForRoom"
        let url = URL(string: "\(SERVER_URL)\(urlPath)")!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [self] (data, response, error) in
            // Everything in this code block is called asynchronously at a 'later' time
            print("Started network call for the class schedule")
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    // Convert the string data into a JSON Object and then convert that JSON object into a Swift Dictionary
                    let classArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [ [String:AnyObject] ]
                    for classDict in classArray {
                        // Setup the dateformatter to read the server data
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        let startDate = dateFormatter.date(from: classDict["startTime"]! as! String)!
                        
                        let endDate = dateFormatter.date(from: classDict["endTime"]! as! String)!
                        
                        // Create a new class based on the server data
                        self.classBlocks.append(ClassBlock(className: classDict["className"]! as! String, teacherName: classDict["teacherName"]! as! String, startTime: startDate, endTime: endDate, blockName: classDict["blockName"]! as! String))
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
    func getCurrentClass() -> ClassBlock? {
        // Search through all the classes
        for classBlock in classBlocks {
            // Return the one that is now
            print("Start time: \(classBlock.startTime)")
            print("Now: \(Date())")
            print("End time: \(classBlock.endTime)")
            if Date() >= classBlock.startTime && Date() <= classBlock.endTime {
                return classBlock
            }
        }
        return nil
    }
    
    /* Calculates and returns the time left before the bell rings for the current class */
    func timeLeftInClass() -> TimeInterval {
        // TODO: Implement
        // Hint, you have a function that can give you the current class...
        return TimeInterval()
    }
}

