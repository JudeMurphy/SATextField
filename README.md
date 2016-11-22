## SATextField
A UITextField with types! Included types: email, phone number, first name, last name and password. SATextField allows you to simply validate it's format with one method call! No more need to write out long validation methods for a sign-up or login page. Lightweight and easy to use!

## How To Use SATextField

```swift
// Declare Sample TextField
var textFieldExample1: SATextField = SATextField()

// Storyboard Declaration Example
textFieldExample1.type(textFieldType: .Email)

// Programmatic Declaration Example
textFieldExample1 = SATextField(frame: CGRect(x: 100, y: 100, width: 200, height: 50), type: .Email)
textFieldExample1.backgroundColor = UIColor.gray
textFieldExample1.center = self.view.center
textFieldExample1.delegate = self
self.view.addSubview(textFieldExample1)
```

## Required Methods (Drop and Drop)

```swift
// Example Of How To Utilize Built-In Validation Features Of SATextField
// NEED THIS METHOD FOR VALIDATION METHOD TO WORK
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
{
    // Don't Allow The User To Enter A Space
    if textField.isKind(of: SATextField.self)
    {
        // Can Change shouldUpdateUI to false
        (textField as! SATextField).containsValidInput(range: range, string: string, shouldUpdateUI: true)
    }
        
    return true
}

// Example Of How To Run Validations
@IBAction func validateTextFields(_ sender: AnyObject)
{
    if (textFieldExample1.textIsValidated() == true)
    {
        print("ALL TEXTFIELDS HAVE BEEN VALIDATED")
    }
    else
    {
        print("THERE ARE ONE ORE MORE TEXTFIELDS THAT HAVE NOT BEEN VALIDATED")
    }
}
```

## Optional, but Recommended Methods (Drop and Drop)

```swift
// Example Of Sample Trim Method Used By TextField
func textFieldDidEndEditing(_ textField: UITextField)
{
   textFieldExample1.text = textFieldExample1.text?.trim()
}
```

## Motivation

I got tired of rewriting my validation methods for textfields everytime I did a sign-up screen. So this is here to solve anyone else's headache with this as well!

## Installation

Just add SATextField.swift to any project, and you're good to go!

## Contributors

Jude Murphy

## License

MIT License
