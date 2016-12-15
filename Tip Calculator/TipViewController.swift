//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Timothy Mak on 12/8/16.
//  Copyright © 2016 Timothy Mak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipTitle: UILabel!
    @IBOutlet weak var totalTitle: UILabel!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var splitPersonLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBOutlet weak var splitField: UITextField!
    @IBOutlet weak var splitTotalValue: UILabel!
    
    let tipPercentages = [0.1, 0.15, 0.18]
    var tipPercent = 0.0
    let tipKey = "default_tip_percentage"
    
    var showRounded = false
    let roundedKey = "show/hide rounded"
    
    let splitKey = "show/hide split"
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        defaults.set(tipPercent, forKey: tipKey)
        defaults.set(false, forKey: roundedKey)
        
        defaults.synchronize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    func showSplitLabels(){
        splitPersonLabel.isHidden = false
        splitTotalLabel.isHidden = false
        splitField.isHidden = false
        splitTotalValue.isHidden = false
    }
    
    func hideSplitLabels(){
        splitPersonLabel.isHidden = true
        splitTotalLabel.isHidden = true
        splitField.isHidden = true
        splitTotalValue.isHidden = true
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        // ?? checks if text is valid - if not, return 0
        let bill = Double(billField.text!) ?? 0
        let tip = (bill * tipPercent)
        let total = bill + tip
        let roundedTotal = round(total)
        let roundedTip = roundedTotal - bill
        
        //set the labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        let rounded = defaults.bool(forKey: roundedKey)
        
        if(rounded){
            tipTitle.text = "Tip (Rounded)"
            totalTitle.text = "Total (Rounded)"
            tipLabel.text = tipLabel.text! + " (" + String(format: "$%.2f", roundedTip) + ")"
            totalLabel.text = totalLabel.text! + " (" + String(format: "$%.2f", roundedTotal) + ")"
        }
        else{
            tipTitle.text = "Tip"
            totalTitle.text = "Total"
            tipLabel.text = tipLabel.text!
            totalLabel.text = totalLabel.text!
        }
        
    }

    @IBAction func tipValueChange(_ sender: Any) {
        tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        calculateTip(self)
        
        //save the key to UserDefaults
        defaults.set(tipPercent, forKey: tipKey)
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Make the keyboard automatically appear
        billField.becomeFirstResponder()
        
        tipPercent = defaults.double(forKey: tipKey)
        
        if(tipPercent == tipPercentages[0]){
            tipControl.selectedSegmentIndex = 0
        }
        else if(tipPercent == tipPercentages[1]){
            tipControl.selectedSegmentIndex = 1
        }
        else{
            tipControl.selectedSegmentIndex = 2
        }
        calculateTip(self)
        
        let split = defaults.bool(forKey: splitKey)
        
        if(split){
            showSplitLabels()
        }
        else{
            hideSplitLabels()
        }

    }
    
}

