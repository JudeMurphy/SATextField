//
//  ViewController.swift
//  SATextField
//
//  Created by Jude Murphy on 10/16/16.
//  Copyright © 2016 Spark Apps, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    var textFieldExample1: SATextField = SATextField()
    var textFieldExample2: SATextField = SATextField()
    
    var allTextFieldsValidated: Bool = false
    
    override func viewDidAppear(_ animated: Bool)
    {
        // 1st Example Declaration Of Type
        textFieldExample1 = SATextField(frame: CGRect(x: 100, y: 100, width: 200, height: 50), type: .Email)
        textFieldExample1.backgroundColor = UIColor.gray
        textFieldExample1.center = self.view.center
        textFieldExample1.delegate = self
        self.view.addSubview(textFieldExample1)
        
        // 2nd Example Declaration Of Type
        textFieldExample2 = SATextField(frame: CGRect(x: 100, y: 175, width: 200, height: 50), type: .Password)
        textFieldExample2.backgroundColor = UIColor.gray
        textFieldExample2.center.y = self.view.center.y + 75
        textFieldExample2.center.x = self.view.center.x
        textFieldExample2.delegate = self
        self.view.addSubview(textFieldExample2)
        
        // Alternative Example - If Storyboarded
        textFieldExample1.type(textFieldType: .PhoneNumber)
        textFieldExample2.type(textFieldType: .Email)
    }
    
    // Example Of How To Utilize Built-In Validation Features Of SATextField
    // NEED THIS METHOD FOR VALIDATION METHOD TO WORK
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        // Don't Allow The User To Enter A Space
        if textField.isKind(of: SATextField.self)
        {
            (textField as! SATextField).containsValidInput(range: range, string: string, shouldUpdateUI: true)
        }
        
        return true
    }
    
    // Example Of Sample Trim Method Used By TextField
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textFieldExample1.text = textFieldExample1.text?.trim()
        textFieldExample2.text = textFieldExample2.text?.trim()
    }
    
    // Example Of How To Run Validations
    @IBAction func validateTextFields(_ sender: AnyObject)
    {
        if ((textFieldExample1.textIsValidated() && textFieldExample2.textIsValidated()) == true)
        {
            print("ALL TEXTFIELDS HAVE BEEN VALIDATED")
        }
        else
        {
            print("THERE ARE ONE ORE MORE TEXTFIELDS THAT HAVE NOT BEEN VALIDATED")
        }
    }
}

