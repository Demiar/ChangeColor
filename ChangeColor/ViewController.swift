//
//  ViewController.swift
//  ChangeColor
//
//  Created by Алексей on 21.05.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1.0
        )
        
        redLabel.text = String(format: "%.2f", CGFloat(redSlider.value))
        greenLabel.text = String(format: "%.2f", CGFloat(greenSlider.value))
        blueLabel.text = String(format: "%.2f", CGFloat(blueSlider.value))
    }
    
    @IBAction func changeRedValue(_ sender: UISlider) {
        changeColor(slider: sender,
                    color: redLabel,
                    tintColor: UIColor.red,
                    sliderColor: redSlider
        )
    }
    
    @IBAction func changeGreenValue(_ sender: UISlider) {
        changeColor(slider: sender,
                    color: greenLabel,
                    tintColor: UIColor.green,
                    sliderColor: greenSlider
        )
    }
    
    @IBAction func changeBlueColor(_ sender: UISlider) {
        changeColor(slider: sender,
                    color: blueLabel,
                    tintColor: UIColor.blue,
                    sliderColor: blueSlider
        )
    }
    
    func changeColor(slider: UISlider, color: UILabel, tintColor: UIColor, sliderColor: UISlider) {
        slider.minimumTrackTintColor = tintColor
        sliderColor.value = slider.value
        color.text = String(format: "%.2f", slider.value)
        
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1.0
        )
    }
}

