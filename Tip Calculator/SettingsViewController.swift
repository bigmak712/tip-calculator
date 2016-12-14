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
    
    let tipPercentages = [0.1, 0.15, 0.18]
    var tipPercent = 0.0
    let tipKey = "default_tip_percentage"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setDefaultTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(tipPercentages[settingsTipSegment.selectedSegmentIndex], forKey: tipKey)
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //load the key
        let defaults = UserDefaults.standard
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
    }
}
