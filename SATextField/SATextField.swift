//
//  SATextField.swift
//  SATextField
//
//  Created by Jude Murphy on 10/16/16.
//  Copyright © 2016 Spark Apps, LLC. All rights reserved.
//

import UIKit

/*
 Callable Methods
 func type(type: TextFieldType)
 func textIsValidated() -> Bool
 */

// Enum For Types of TextField
// To Add More In The Future
enum TextFieldType
{
    case None
    case Email
    case FirstName
    case LastName
    case Password
    case PhoneNumber
}

class SATextField: UITextField
{
    // Variables For SATextField
    // Should Only Use DefineType For Setting This Variable
    private var type: TextFieldType = .None
    private var isValidated: Bool = false
    
    //______________________________________________________________
    // Override Initializers
    init(frame: CGRect, type: TextFieldType)
    {
        super.init(frame: frame)
        self.type(textFieldType: type);
    }
    
    // Override Initializers
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        type(textFieldType: .None);
    }
    
    // Override Initializers
    required override init(frame: CGRect)
    {
        super.init(frame: frame)
        type(textFieldType: .None);
    }
    
    //______________________________________________________________
    // Define TextField Properties Based Type
    func type(textFieldType: TextFieldType)
    {
        self.type = textFieldType
        
        switch type
        {
        case .FirstName:
            self.autocapitalizationType = .words
            self.isSecureTextEntry = false
            self.placeholder = " First Name"
            self.keyboardType = .default
            
        case .LastName:
            self.autocapitalizationType = .words
            self.isSecureTextEntry = false
            self.placeholder = " Last Name"
            self.keyboardType = .default
            
        case .Email:
            self.autocapitalizationType = .none
            self.isSecureTextEntry = false
            self.placeholder = " Email"
            self.keyboardType = .emailAddress
            
        case .Password:
            self.autocapitalizationType = .none
            self.isSecureTextEntry = true
            self.placeholder = " Password"
            self.keyboardType = .default
            
        case .PhoneNumber:
            self.autocapitalizationType = .none
            self.isSecureTextEntry = false
            self.placeholder = " Phone Number"
            self.keyboardType = .default
            
        default:
            self.autocapitalizationType = .none
            self.isSecureTextEntry = false
        }
        
        self.autocorrectionType = .no
    }
    
    //______________________________________________________________
    // Validates Input Based On Type
    // Call This Function From TextField Delegate: func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    func containsValidInput(range: NSRange, string: String, shouldUpdateUI : Bool)
    {
        // Gets Current String In Corresponding TextField
        let textFieldText: NSString = (self.text ?? "") as NSString
        let replacementString = textFieldText.replacingCharacters(in: range, with: string)
        
        // Required To Fix Validation Bug
        if string == " "
        {
            // Do Nothing
        }
            // Check If There Is Any Text
        else if(replacementString.characters.count == 0)
        {
            self.isValidated = false
        }
        else if (self.type == .Email)
        {
            // Check If This Is A Valid Email
            if (replacementString.isValidEmail())
            {
                self.isValidated = true
            }
            else
            {
                self.isValidated = false
            }
        }
        else if (self.type == .Password)
        {
            // Check If Password Is Equal To/Greater Than 8 Characters
            if (replacementString.characters.count) > 7
            {
                self.isValidated = true
            }
            else
            {
                self.isValidated = false
            }
        }
        else if (self.type == .PhoneNumber)
        {
            if (replacementString.isValidPhoneNumber() &&
                replacementString.characters.count >= 7)
            {
                self.isValidated = true
            }
            else
            {
                self.isValidated = false
            }
        }
        else
        {
            self.isValidated = true
        }
        
        // If The Developer Wants to Update The TextField With A Red Outline/Clear Outline, Pass In True
        if shouldUpdateUI == true
        {
            if self.isValidated == true
            {
                self.clearRedHighlight()
            }
            else
            {
                self.highlightBorderRed()
            }
        }
    }
    
    // Returns If TextField's Text Is Validated
    func textIsValidated() -> Bool
    {
        return self.isValidated;
    }
    
    //______________________________________________________________
    // Private methods to handle UI highlighting
    private func highlightBorderRed()
    {
        self.layer.borderWidth = 0.75
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    private func clearRedHighlight()
    {
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
}

//______________________________________________________________
// Required Extensions For String Validation
extension String
{
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return self == filtered
    }
}
