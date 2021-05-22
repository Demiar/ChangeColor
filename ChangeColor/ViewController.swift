//
//  ViewController.swift
//  ChangeColor
//
//  Created by Алексей on 21.05.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    
    var red: CGFloat = 0.5
    var green: CGFloat = 0.5
    var blue: CGFloat = 0.5
    
    @IBAction func addRedColor(_ sender: UISlider) {
        sender.minimumTrackTintColor = UIColor.red
        red = CGFloat(sender.value)
        redValue.text = String(format: "%.2f", sender.value)
        displayColors()
    }
    
    @IBAction func addGreenColor(_ sender: UISlider) {
        sender.minimumTrackTintColor = UIColor.green
        green = CGFloat(sender.value)
        greenValue.text = String(format: "%.2f", sender.value)
        displayColors()
    }
    
    @IBAction func addBlueColor(_ sender: UISlider) {
        sender.minimumTrackTintColor = UIColor.blue
        blue = CGFloat(sender.value)
        blueValue.text = String(format: "%.2f", sender.value)
        displayColors()
    }
    
    func displayColors() {
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

