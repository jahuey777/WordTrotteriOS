//
//  ConversionViewController.swift
//  WordTrotter
//
//  Created by jaime jahuey on 10/23/17.
//  Copyright © 2017 jaime jahuey. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCelsiusLabel()
    }
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        //called every time a new value for farenheitValue is set
        didSet{
            updateCelsiusLabel()
        }
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
    
    //dismisses keyboard when screen is tapped
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    //computes the celsiusValue
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue{
            return fahrenheitValue.converted(to: .celsius)
        }else{
            return  nil
        }
    }
    
    //Called in the didSet after the fahrentheit is set.
    func updateCelsiusLabel(){
        //This is when the celsius value gets calculated.
        if let celsiusValue = celsiusValue{
            celsiusLabel.text = "\(celsiusValue.value)"
        }else {
            celsiusLabel.text = "???"
        }
    }
    
}
