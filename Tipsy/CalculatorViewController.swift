//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

  @IBOutlet weak var billTextField: UITextField!

  @IBOutlet weak var zeroPctButton: UIButton!
  @IBOutlet weak var tenPctButton: UIButton!
  @IBOutlet weak var twentyPctButton: UIButton!
  @IBOutlet weak var splitNumberLabel: UILabel!

  var userSelectedTip: Double = 0.1
  var userSelectedSplit: Int = 0
    var finalResult = "0.0"

  @IBAction func tipChanged(_ sender: UIButton) {
      billTextField.endEditing(true)
    if sender.currentTitle == "0%" {
      zeroPctButton.isSelected = true
      tenPctButton.isSelected = false
      twentyPctButton.isSelected = false
      userSelectedTip = 0.0
    } else if sender.currentTitle == "10%" {
      zeroPctButton.isSelected = false
      tenPctButton.isSelected = true
      twentyPctButton.isSelected = false
      userSelectedTip = 0.1
    } else {
      zeroPctButton.isSelected = false
      tenPctButton.isSelected = false
      twentyPctButton.isSelected = true
      userSelectedTip = 0.2
    }
  }

  @IBAction func stepperValueChanged(_ sender: UIStepper) {
    splitNumberLabel.text = String(format: "%.0f", sender.value)
    userSelectedSplit = Int(sender.value)
  }

  @IBAction func calculatePressed(_ sender: UIButton) {
    let bill = Double(billTextField.text!) ?? 0.0
    let tip = bill * userSelectedTip
    let total = bill + tip
    let split = total / Double(userSelectedSplit)
    let result = String(format: "%.2f", split)
      finalResult = result
    billTextField.endEditing(true)
    print(result)
    performSegue(withIdentifier: "goToResult", sender: self)
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = finalResult
            destinationVC.tip = Int(userSelectedTip * 100)
            destinationVC.split = userSelectedSplit
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

}
