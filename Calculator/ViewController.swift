//
//  ViewController.swift
//  Calculator
//
//  Created by Eldor Makkambaev on 29.01.2018.
//  Copyright © 2018 Eldor Makkambaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    var typing : Bool = false
    private var change = changeButtons()
    
    
    @IBAction func changeButton(_ sender: UIButton) {
        let list = change.getState
        for i in 0...13 {
            let button = (view.viewWithTag(i+10) as? UIButton)!
            button.setTitle(list[i], for: UIControlState.normal)
        }

    }
    
    
    @IBAction func buttons(_ sender: UIButton) {
        if typing && myLabel.text! != "0" {
            myLabel.text! += (sender.titleLabel?.text)!
        }else{
            myLabel.text = sender.currentTitle!
            typing = true
        }
    }
    
    var displayValue: Double{
        get{
            var result = Double(myLabel.text!)!
            if myLabel.text! == "Error!"{
                result = Double.infinity
            }
            return result
        }
        set{
            if newValue == Double.infinity{
                myLabel.text = "Error!"
            }else if floor(newValue) == newValue{
                myLabel.text = String(Int(newValue))
            }
            else{
                myLabel.text = String(newValue)
                
            }
        }
    }
    
    private var mymodel = CalcModel()
    
    
    @IBAction func operations(_ sender: UIButton) {
        if typing{
            mymodel.setOperand(displayValue)
            typing = false
        }
        mymodel.performOperation(sender.currentTitle!, true)
        if let result = mymodel.result{
            displayValue = result
        }
    }
}



