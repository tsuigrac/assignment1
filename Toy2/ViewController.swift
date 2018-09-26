//
//  ViewController.swift
//  Toy2
//
//  Created by Grace Tsui on 9/16/18.
//  Copyright © 2018 Grace Tsui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // The boolean for if the information is submitted is initialized to false
    var submitted : Bool = false
    
    // Connections from storyboard
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var ClassTextField: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ClassLabel: UILabel!
    @IBOutlet weak var DisplayLabel: UILabel!
    
    // Called when the user taps the submit button
    func submitMode(name: String, classYear: String) -> Void {
        submitted = true
        
        // Set the button text to "Clear"
        SubmitButton.setTitle("Clear", for: .normal)
        
        //Set the display label text
        DisplayLabel.text = "Welcome, \(name) of \(classYear)!"
        
        // Hide the labels and text fields
        NameLabel.isHidden = true
        ClassLabel.isHidden = true
        NameTextField.isHidden = true
        ClassTextField.isHidden = true
    }
    
    // Called when the user taps the clear button
    func clearMode() -> Void {
        submitted = false
        
        // Reset the button label back to "Submit"
        SubmitButton.setTitle("Submit", for: .normal)
        
        // Make all labels and text fields visible
        NameLabel.isHidden = false
        ClassLabel.isHidden = false
        NameTextField.isHidden = false
        ClassTextField.isHidden = false
        
        // Reset all text in text fields and labels
        NameTextField.text = ""
        ClassTextField.text = ""
        DisplayLabel.text = "None"
        
        // Reset user defaults
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "class")
    }
    
    // Called whenever the button is tapped
    @IBAction func SubmitTapped(_ sender: UIButton) {
       // If the submit button is tapped
        if (!submitted) {
            // Retrieve text from each text field
            let name = NameTextField.text ?? ""
            let classYear = ClassTextField.text ?? ""
            
            // Call the method to alter buttons/text fields
            submitMode(name: name, classYear: classYear)
            
            // Set user defaults
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(classYear, forKey: "class")
        }
        // If the user taps the "Clear" button
        else {
            // Call the method to reset screen
            clearMode()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // If there is a user default stored, display it on the screen
        if (UserDefaults.standard.object(forKey: "name") != nil) {
            let name = UserDefaults.standard.string(forKey: "name")
            let classYear = UserDefaults.standard.string(forKey: "class")
            submitMode(name: name!, classYear: classYear!)
        }
        else {
            clearMode()
        }
        
        // Adds cats from Internet to array if there are no current cats
        if (Cat.count == 0) {
            Cat.loadCats { (result) in
                
                // Add each cat in dictionary array to app
                for dict in result {
                    
                    // Get image using image URL provided by array
                    let imageURL = URL(string: dict["image"]!)
                    let image = UIImage(data: try! Data(contentsOf: imageURL!))
                    
                    // Initialize cat characteristics from array
                    let name = dict["name"]!
                    let age = Int(dict["age"]!)
                    let breed = dict["type"]!
                    
                    // Add cat to app
                    Cat.addCat(name: name, image: image, age: age, breed: breed)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

