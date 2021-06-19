//
//  SettingsViewController.swift
//  OIS Dashboard
//
//  Created by Jeremy Anderson on 24/05/2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var roomNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        if let savedRoomNumber = defaults.object(forKey: "RoomNumber") as? String {
            roomNumberTextField.text = savedRoomNumber
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func savedRoomNumber(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(roomNumberTextField.text, forKey: "RoomNumber")
    }
}
