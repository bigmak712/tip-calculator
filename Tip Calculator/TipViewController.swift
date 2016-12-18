//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Timothy Mak on 12/8/16.
//  Copyright © 2016 Timothy Mak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billTitle: UILabel!
    @IBOutlet weak var tipTitle: UILabel!
    @IBOutlet weak var totalTitle: UILabel!
    @IBOutlet weak var barDivider: UIView!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var splitPersonLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBOutlet weak var splitField: UITextField!
    @IBOutlet weak var splitTotalValue: UILabel!
    
    var tipPercentages = [0.1, 0.15, 0.18]
    var tipPercent = 0.0
    let tipKey = "default_tip_percentage"
    
    var showRounded = false
    let roundedKey = "show/hide rounded"
    
    let splitKey = "show/hide split"
    
    let customTipKey1 = "custom tip key 1"
    let customTipKey2 = "custom tip key 2"
    let customTipKey3 = "custom tip key 3"
    
    let customGreen = UIColor(red:0.1098, green: 0.4078, blue: 0.0118, alpha: 1.0)
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = customGreen
        billTitle.textColor = UIColor .white
        tipTitle.textColor = UIColor .white
        totalTitle.textColor = UIColor .white
        barDivider.backgroundColor = UIColor .white
        tipLabel.textColor = UIColor .white
        totalLabel.textColor = UIColor .white
        billField.textColor = UIColor .black
        splitPersonLabel.textColor = UIColor .white
        splitTotalLabel.textColor = UIColor .white
        splitField.textColor = UIColor .white
        splitTotalValue.textColor = UIColor .white
        tipControl.tintColor = UIColor .white
        
        // Set the initial selected segment to be the first one
        tipControl.selectedSegmentIndex = 0
        
        // Set the initial tipPercent
        defaults.set(tipPercentages[0], forKey: tipKey)
        
        // Set the rounded tip/total and split check option to false
        defaults.set(false, forKey: roundedKey)
        defaults.set(false, forKey: splitKey)
        
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
        var numOfSplits = Double(splitField.text!) ?? 1
        
        if(numOfSplits < 1){
            numOfSplits = 1
        }
        
        let splitTotal = (ceil((total * 100)/numOfSplits))/100
        let roundedSplitTotal = (ceil((roundedTotal * 100)/numOfSplits))/100
        
        let rounded = defaults.bool(forKey: roundedKey)
        
        if(rounded){
            tipTitle.text = "Tip (Rounded)"
            totalTitle.text = "Total (Rounded)"
            splitTotalLabel.text = "Split Total (Rounded)"
            tipLabel.text = String(format: "$%.2f", roundedTip)
            totalLabel.text = String(format: "$%.2f", roundedTotal)
            splitTotalValue.text = String(format: "$%.2f", roundedSplitTotal)
        }
        else{
            tipTitle.text = "Tip"
            totalTitle.text = "Total"
            splitTotalLabel.text = "Split Total"
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
            splitTotalValue.text = String(format: "$%.2f", splitTotal)
        }
        
    }

    @IBAction func tipValueChange(_ sender: Any) {
        
        // Set the tipPercent to the selected tip percentage and recalculate
        tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        calculateTip(self)
        
        // Save the key to UserDefaults
        defaults.set(tipPercent, forKey: tipKey)
        defaults.synchronize()
    }
    
    @IBAction func splitPersonsChange(_ sender: Any) {
        calculateTip(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Make the keyboard automatically appear
        billField.becomeFirstResponder()
        
        // Get the custom tip percentages
        var custom1 = defaults.double(forKey: customTipKey1)
        var custom2 = defaults.double(forKey: customTipKey2)
        var custom3 = defaults.double(forKey: customTipKey3)

        // Set the values in the tipPercentages array
        tipPercentages[0] = custom1
        tipPercentages[1] = custom2
        tipPercentages[2] = custom3
        
        // Load the default tip key
        tipPercent = defaults.double(forKey: tipKey)
        
        // Set the selected tipControl segment
        if(tipPercent == tipPercentages[0]){
            tipControl.selectedSegmentIndex = 0
        }
        else if(tipPercent == tipPercentages[1]){
            tipControl.selectedSegmentIndex = 1
        }
        else{
            tipControl.selectedSegmentIndex = 2
        }

        // Multiply the custom tip percentages by 100
        custom1 = custom1 * 100
        custom2 = custom2 * 100
        custom3 = custom3 * 100

        // Set the titles in the segment control to the custom tip percentages
        tipControl.setTitle(String(format: "%.0f", custom1) + "%", forSegmentAt: 0)
        tipControl.setTitle(String(format: "%.0f", custom2) + "%", forSegmentAt: 1)
        tipControl.setTitle(String(format: "%.0f", custom3) + "%", forSegmentAt: 2)

        // Recalculate the tip
        calculateTip(self)
        
        // Load the split check boolean
        let split = defaults.bool(forKey: splitKey)
        
        // Show/hide the split check labels depending on the split boolean
        if(split){
            showSplitLabels()
        }
        else{
            hideSplitLabels()
        }

    }
    
}

