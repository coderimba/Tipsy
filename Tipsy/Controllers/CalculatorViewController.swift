//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    var bill: Float = 0.0
    var tipPct: String = ""
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var twelvePctButton: UIButton!
    @IBOutlet weak var fifteenPctButton: UIButton!
    @IBOutlet weak var eighteenPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            twelvePctButton.isSelected = false
            fifteenPctButton.isSelected = false
            eighteenPctButton.isSelected = false
            sender.isSelected = true
        }
        billTextField.endEditing(true) //this dismisses the keyboard when one of the tip buttons is pressed (this line of code will be triggered when one of the tip buttons is pressed)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = "\(Int (sender.value))"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        if twelvePctButton.isSelected {
            tipPct = "12%"
            bill = calculate(0.12)
        } else if fifteenPctButton.isSelected {
            tipPct = "15%"
            bill = calculate(0.15)
        } else if eighteenPctButton.isSelected {
            tipPct = "18%"
            bill = calculate(0.18)
        } else {
            tipPct = "0%"
            bill = calculate(0)
        }
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = bill
            destinationVC.settings = "No. of people splitting: " + splitNumberLabel.text! + "\nTip: " + tipPct
        }
    }
    
    func calculate(_ tipPct: Float) -> Float {
        return ((billTextField.text! as NSString).floatValue * (1 + tipPct)) / (splitNumberLabel.text! as NSString).floatValue
    }

}

