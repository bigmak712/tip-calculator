//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Timothy Mak on 12/9/16.
//  Copyright © 2016 Timothy Mak. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var setDefaultTipTitle: UILabel!
    @IBOutlet weak var setFirstTipTitle: UILabel!
    @IBOutlet weak var setSecondTipTitle: UILabel!
    @IBOutlet weak var setThirdTipTitle: UILabel!
    
    @IBOutlet weak var settingsTipSegment: UISegmentedControl!
    @IBOutlet weak var roundedButton: UIButton!
    @IBOutlet weak var splitButton: UIButton!
    
    @IBOutlet weak var customTip1: UITextField!
    @IBOutlet weak var customTip2: UITextField!
    @IBOutlet weak var customTip3: UITextField!
    
    let defaultTip1 = 0.15
    let defaultTip2 = 0.18
    let defaultTip3 = 0.2
    
    var tipPercentages = [0.15, 0.18, 0.2]
    var tipPercent = 0.0
    let tipKey = "default_tip_percentage"
    let roundedKey = "show/hide rounded"
    let splitKey = "show/hide split"
    var roundedShown = false
    var splitShown = false
    
    let customTipKey1 = "custom tip key 1"
    let customTipKey2 = "custom tip key 2"
    let customTipKey3 = "custom tip key 3"
    
    let buttonBorderWidth = CGFloat(1)
    let buttonCornerRadius = CGFloat(5)
    
    let customGreen = UIColor(red:0.1098, green: 0.4078, blue: 0.0118, alpha: 1.0)
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = customGreen
        setDefaultTipTitle.textColor = UIColor.white
        setFirstTipTitle.textColor = UIColor.white
        setSecondTipTitle.textColor = UIColor.white
        setThirdTipTitle.textColor = UIColor.white
        settingsTipSegment.tintColor = UIColor.white
        roundedButton.setTitleColor(UIColor.white, for: .normal)
        roundedButton.layer.borderColor = UIColor.white.cgColor
        roundedButton.layer.borderWidth = buttonBorderWidth
        roundedButton.layer.cornerRadius = buttonCornerRadius
        splitButton.setTitleColor(UIColor.white, for: .normal)
        splitButton.layer.borderColor = UIColor.white.cgColor
        splitButton.layer.borderWidth = buttonBorderWidth
        splitButton.layer.cornerRadius = buttonCornerRadius
        customTip1.textColor = customGreen
        customTip2.textColor = customGreen
        customTip3.textColor = customGreen
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func setDefaultTip(_ sender: Any) {
        
        //set the default tip percentage and save it
        defaults.set(tipPercentages[settingsTipSegment.selectedSegmentIndex], forKey: tipKey)
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load the default tip percentages
        var custom1 = defaults.double(forKey: customTipKey1)
        var custom2 = defaults.double(forKey: customTipKey2)
        var custom3 = defaults.double(forKey: customTipKey3)
        
        // If any tip percentages are 0%, set them to the default tip values
        if(custom1 == 0){
            custom1 = defaultTip1
        }
        if(custom2 == 0){
            custom2 = defaultTip2
        }
        if(custom3 == 0){
            custom3 = defaultTip3
        }
        
        // Update the tipPercentages array values
        tipPercentages[0] = custom1
        tipPercentages[1] = custom2
        tipPercentages[2] = custom3
        
        // Multiply the default tip percentages by 100
        custom1 = custom1 * 100
        custom2 = custom2 * 100
        custom3 = custom3 * 100
        
        // Set the segment control titles to the 3 default tip percentages
        settingsTipSegment.setTitle(String(format: "%.0f", custom1) + "%", forSegmentAt: 0)
        settingsTipSegment.setTitle(String(format: "%.0f", custom2) + "%", forSegmentAt: 1)
        settingsTipSegment.setTitle(String(format: "%.0f", custom3) + "%", forSegmentAt: 2)

        
        // Load the default tip key
        tipPercent = defaults.double(forKey: tipKey)
        
        if(tipPercent == tipPercentages[0]){
            settingsTipSegment.selectedSegmentIndex = 0
        }
        else if(tipPercent == tipPercentages[1]){
            settingsTipSegment.selectedSegmentIndex = 1
        }
        else{
            settingsTipSegment.selectedSegmentIndex = 2
        }
        
        // Load the rounded key
        let rounded = defaults.bool(forKey: roundedKey)
        
        // Rounded enabled - set the button to hide and set the rounded boolean to true
        if(rounded){
            roundedButton.setTitle("Hide Rounded Tip/Total", for: .normal)
            roundedShown = true
        }
            
        // Rounded disabled - set the button to show and set the rounded boolean to false
        else{
            roundedButton.setTitle("Show Rounded Tip/Total", for: .normal)
            roundedShown = false
        }
        
        //load the split key
        let split = defaults.bool(forKey: splitKey)
        
        // Split Check enabled - set the button to disable and set the split boolean to true
        if(split){
            splitButton.setTitle("Disable Split Check Option", for: .normal)
            splitShown = true
        }
            
        // Split Check disabled - set the button to enable and set the split boolean to false
        else{
            splitButton.setTitle("Enable Split Check Option", for: .normal)
            splitShown = false
        }
    }
    
    @IBAction func changeCustomTip1(_ sender: Any) {
        
        // Set tip1 to the text for the Custom Tip 1 text field
        var tip1 = (Double(customTip1.text!) ?? 0)
        
        // tip1 value is between 0 and 100 exclusive
        if(tip1 > 0 && tip1 < 100){
            
            // Set the first segment to the new tip value
            settingsTipSegment.setTitle(String(format: "%.0f", tip1) + "%", forSegmentAt: 0)
            
            // Divide the tip by 100 to get the percentage value
            tip1 = tip1 / 100
            
            // Update the tip percentage in the tipPercentages array
            tipPercentages[0] = tip1
            
            // Update the tip key if the selected tip was changed
            if(settingsTipSegment.selectedSegmentIndex == 0){
                defaults.set(tip1, forKey: tipKey)
            }
            
            // Save the new default tip percentage
            defaults.set(tip1, forKey: customTipKey1)
            defaults.synchronize()
        }
            
        // tip1 is an invalid tip value
        else{
            // Set the first segment to the default first tip value - 15%
            settingsTipSegment.setTitle("15%", forSegmentAt: 0)
            
            // Update the tip percentage in the tipPercentages array to defaultTip1
            tipPercentages[0] = defaultTip1
            
            // Update the tip key if the selected tip was changed
            if(settingsTipSegment.selectedSegmentIndex == 0){
                defaults.set(tipPercentages[0], forKey: tipKey)
            }
            
            // Save the new default tip percentage
            defaults.set(tipPercentages[0], forKey: customTipKey1)
            defaults.synchronize()

        }
    }
    
    @IBAction func changeCustomTip2(_ sender: Any) {
        
        // Set tip2 to the text for the Custom Tip 2 text field
        var tip2 = (Double(customTip2.text!) ?? 0)
        
        // tip2 value is between 0 and 100 exclusive
        if(tip2 > 0 && tip2 < 100){
            
            // Set the second segment to the new tip value
            settingsTipSegment.setTitle(String(format: "%.0f", tip2) + "%", forSegmentAt: 1)
            
            // Divide the tip by 100 to get the percentage value
            tip2 = tip2 / 100
            
            // Update the tip percentage in the tipPercentages array
            tipPercentages[1] = tip2
            
            // Update the tip key if the selected tip was changed
            if(settingsTipSegment.selectedSegmentIndex == 1){
                defaults.set(tip2, forKey: tipKey)
            }
            
            // Save the new default tip percentage
            defaults.set(tip2, forKey: customTipKey2)
            defaults.synchronize()
        }
            
        // tip2 is an invalid tip value
        else{
            // Set the second segment to defaultTip2
            settingsTipSegment.setTitle("18%", forSegmentAt: 1)
            
            // Update the tip percentage in the tipPercentages array to the defaultTip2
            tipPercentages[1] = defaultTip2
            
            // Update the tip key if the selected tip was changed
            if(settingsTipSegment.selectedSegmentIndex == 1){
                defaults.set(tipPercentages[1], forKey: tipKey)
            }
            
            // Save the new default tip percentage
            defaults.set(tipPercentages[1], forKey: customTipKey2)
            defaults.synchronize()
            
        }
    }
    
    @IBAction func changeCustomTip3(_ sender: Any) {
        
        // Set tip3 to the text for the Custom Tip 3 text field
        var tip3 = (Double(customTip3.text!) ?? 0)
        
        // tip3 value is between 0 and 100 exclusive
        if(tip3 > 0 && tip3 < 100){
            
            // Set the third segment to the new tip value
            settingsTipSegment.setTitle(String(format: "%.0f", tip3) + "%", forSegmentAt: 2)
            
            // Divide the tip by 100 to get the percentage value
            tip3 = tip3 / 100
            
            // Update the tip percentage in the tipPercentages array
            tipPercentages[2] = tip3
            
            // Update the tip key if the selected tip was changed
            if(settingsTipSegment.selectedSegmentIndex == 2){
                defaults.set(tip3, forKey: tipKey)
            }
            
            // Save the new default tip percentage
            defaults.set(tip3, forKey: customTipKey3)
            defaults.synchronize()
        }
        
        // tip3 is an invalid tip value
        else{
            // Set the first segment to the defaultTip3
            settingsTipSegment.setTitle("20%", forSegmentAt: 2)
            
            // Update the tip percentage in the tipPercentages array to defaultTip3
            tipPercentages[2] = defaultTip3
            
            // Update the tip key if the selected tip was changed
            if(settingsTipSegment.selectedSegmentIndex == 2){
                defaults.set(tipPercentages[2], forKey: tipKey)
            }
            
            // Save the new default tip percentage
            defaults.set(tipPercentages[2], forKey: customTipKey3)
            defaults.synchronize()
            
        }

    }
    
    @IBAction func switchRounded(_ sender: Any) {
        
        // Hide the rounded tip/total
        if(roundedShown){
            roundedButton.setTitle("Show Rounded Tip/Total", for: .normal)
            defaults.set(false, forKey: roundedKey)
            defaults.synchronize()
        }
            
        // Show the rounded tip/total
        else{
            roundedButton.setTitle("Hide Rounded Tip/Total", for: .normal)
            defaults.set(true, forKey: roundedKey)
            defaults.synchronize()
        }
        
        roundedShown = !roundedShown
    }
    
    @IBAction func switchSplit(_ sender: Any) {
        
        // Set text to enable split option
        if(splitShown){
            splitButton.setTitle("Enable Split Check Option", for: .normal)
            defaults.set(false, forKey: splitKey)
            defaults.synchronize()
        }
        
        // Set text to disable split option
        else{
            splitButton.setTitle("Disable Split Check Option", for: .normal)
            defaults.set(true, forKey: splitKey)
            defaults.synchronize()
        }
        
        splitShown = !splitShown
    }
    
    
}
