//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Timothy Mak on 12/8/16.
//  Copyright © 2016 Timothy Mak. All rights reserved.
//

import UIKit

/*
 * Description: View Controller that is in charge of the actual tip 
 * calculator view where the user will be inputting the bill amount,
 * selecting the tip percentage, and viewing the total amount.
 */
class ViewController: UIViewController {
    
    // Labels that notate the bill, tip, and total amount
    @IBOutlet weak var billTitle: UILabel!
    @IBOutlet weak var tipTitle: UILabel!
    @IBOutlet weak var totalTitle: UILabel!
    
    // Bar divider that seperates the bill and tip from the total
    @IBOutlet weak var barDivider: UIView!
    
    // Labels that show the tip/total amount
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    // Text field that the user inputs the bill amount
    @IBOutlet weak var billField: UITextField!
    
    // SegmentedControl that shows the tip percentage
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // Labels and text field for the split check option
    @IBOutlet weak var splitPersonLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBOutlet weak var splitField: UITextField!
    @IBOutlet weak var splitTotalValue: UILabel!
    
    // Default tip percentages that are initially set
    var tipPercentages = [0.15, 0.18, 0.2]
    
    // Default tip percentage that is currently being used
    var tipPercent = 0.0
    
    // Used to save and load saved values
    let defaults = UserDefaults.standard
    
    // Keys used to save/load the tip percentage, rounded boolean, split boolean, and the custom tip percentages
    let tipKey = "default_tip_percentage"
    let roundedKey = "show/hide rounded"
    let splitKey = "show/hide split"
    let customTipKey1 = "custom tip key 1"
    let customTipKey2 = "custom tip key 2"
    let customTipKey3 = "custom tip key 3"
    
    // Custom green color for the app background and the letters
    let customGreen = UIColor(red:0.1098, green: 0.4078, blue: 0.0118, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the color of the tip calculator view controller to be green/white
        self.view.backgroundColor = customGreen
        billTitle.textColor = UIColor .white
        tipTitle.textColor = UIColor .white
        totalTitle.textColor = UIColor .white
        barDivider.backgroundColor = UIColor .white
        tipLabel.textColor = UIColor .white
        totalLabel.textColor = UIColor .white
        billField.textColor = customGreen
        splitPersonLabel.textColor = UIColor .white
        splitTotalLabel.textColor = UIColor .white
        splitField.textColor = customGreen
        splitTotalValue.textColor = UIColor .white
        tipControl.tintColor = UIColor .white
        
        // Set the initial selected segment to be the first one
        tipControl.selectedSegmentIndex = 0
        
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
    
    // Shows the split check labels
    func showSplitLabels(){
        splitPersonLabel.isHidden = false
        splitTotalLabel.isHidden = false
        splitField.isHidden = false
        splitTotalValue.isHidden = false
    }
    
    // Hides the split check labels
    func hideSplitLabels(){
        splitPersonLabel.isHidden = true
        splitTotalLabel.isHidden = true
        splitField.isHidden = true
        splitTotalValue.isHidden = true
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        // ?? checks if text is valid - if not, return 0
        let bill = Double(billField.text!) ?? 0
        
        // Calculate the normal tip/total
        let tip = (bill * tipPercent)
        let total = bill + tip
        
        // Calculate the rounded tip/total
        let roundedTotal = round(total)
        let roundedTip = roundedTotal - bill
        
        // Get the number of times the total will be split
        var numOfSplits = Double(splitField.text!) ?? 1
        
        // If the split number is invalid, set it to be 1
        if(numOfSplits < 1){
            numOfSplits = 1
        }
        
        // Calculate the split total and rounded split total
        let splitTotal = (ceil((total * 100)/numOfSplits))/100
        let roundedSplitTotal = (ceil((roundedTotal * 100)/numOfSplits))/100
        
        // Load the rounded boolean value
        let rounded = defaults.bool(forKey: roundedKey)
        
        // Set the labels to the rounded/normal values depending on the rounded boolean value
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
    
    // Recalculate the total if the number of splits changed
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
        
        // If any tip percentages are 0%, set them to the default tip percentages
        if(custom1 == 0){
            custom1 = tipPercentages[0]
        }
        if(custom2 == 0){
            custom2 = tipPercentages[1]
        }
        if(custom3 == 0){
            custom3 = tipPercentages[2]
        }

        // Set the values in the tipPercentages array
        tipPercentages[0] = custom1
        tipPercentages[1] = custom2
        tipPercentages[2] = custom3
        
        // Load the default tip key
        tipPercent = defaults.double(forKey: tipKey)
        
        // If tipPercent is 0, set it to default tip value 0.15 and save it
        if(tipPercent == 0){
            tipPercent = 0.15
            defaults.set(tipPercent, forKey: tipKey)
            defaults.synchronize()
        }
        
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

