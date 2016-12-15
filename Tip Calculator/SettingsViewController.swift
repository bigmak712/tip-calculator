//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Timothy Mak on 12/9/16.
//  Copyright © 2016 Timothy Mak. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTipSegment: UISegmentedControl!
    @IBOutlet weak var roundedButton: UIButton!
    @IBOutlet weak var splitButton: UIButton!
    
    
    let tipPercentages = [0.1, 0.15, 0.18]
    var tipPercent = 0.0
    let tipKey = "default_tip_percentage"
    let roundedKey = "show/hide rounded"
    let splitKey = "show/hide split"
    var roundedShown = false
    var splitShown = false
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setDefaultTip(_ sender: Any) {
        
        //set the default tip percentage and save it
        defaults.set(tipPercentages[settingsTipSegment.selectedSegmentIndex], forKey: tipKey)
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //load the tip key
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
        
        let rounded = defaults.bool(forKey: roundedKey)
        
        if(rounded){
            roundedButton.setTitle("Hide Rounded Tip/Total", for: .normal)
            roundedShown = true
        }
        else{
            roundedButton.setTitle("Show Rounded Tip/Total", for: .normal)
            roundedShown = false
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
