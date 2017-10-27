//
//  ConversionViewController.swift
//  WordTrotter
//
//  Created by jaime jahuey on 10/23/17.
//  Copyright © 2017 jaime jahuey. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var textField2: UITextField!

    //constant number formatter
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        //called every time a new value for farenheitValue is set
        didSet{
            updateCelsiusLabel()
        }
    }
    
    //computes the celsiusValue
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue{
            return fahrenheitValue.converted(to: .celsius)
        }else{
            return  nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCelsiusLabel()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        celsiusLabel.text = textField.text
        
//        if let text = textField.text, !text.isEmpty{
//            celsiusLabel.text = text
//        }else{
//            celsiusLabel.text = "???"
//        }
        
        //Checking if field has some text and if it can be represented as a double
        if let text = textField.text, let val = Double(text){
            fahrenheitValue = Measurement(value: val, unit: .fahrenheit)
        }else{
            fahrenheitValue = nil
        }
    }
    
    @IBAction func textEditingChanged(_ textField: UITextField){
        celsiusLabel.text = textField.text
        
        if let text = textField.text, !text.isEmpty{
            celsiusLabel.text = text
        }else{
            celsiusLabel.text = "???"
        }
        
        //Checking if field has some text and if it can be represented as a double
//        if let text = textField.text, let val = Double(text){
//            fahrenheitValue = Measurement(value: val, unit: .fahrenheit)
//        }else{
//            fahrenheitValue = nil
//        }
    }
    
    //dismisses keyboard when screen is tapped
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
        textField2.resignFirstResponder()
    }
    
    //Called in the didSet after the fahrentheit is set.
    func updateCelsiusLabel(){
        //This is when the celsius value gets calculated.
        if let celsiusValue = celsiusValue{
//            celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }else {
            celsiusLabel.text = "???"
        }
    }
    
    //The textfield calls this method on its delegate, UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string:String)-> Bool{
//        print("current text: \(textField.text)")
//        print("replacement text: \(string)")

        //reject the change if input already has one decimal in the text
        let existinTextHasDecimalSeperator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeperator = string.range(of: ".")
        
        //Wont allow alphabetic charecters. Could have happened if user pasted or typed with a keyboard 
        let letters = NSCharacterSet.letters
        let existingTextHasLetters = textField.text?.rangeOfCharacter(from: letters)
        let replacementTextHasLetters = string.rangeOfCharacter(from: letters)
        
        if existinTextHasDecimalSeperator != nil, replacementTextHasDecimalSeperator != nil{
            return false
        }
        else if existingTextHasLetters != nil || replacementTextHasLetters != nil{
            return false
        }

        return true
    }
    

    
    
}
