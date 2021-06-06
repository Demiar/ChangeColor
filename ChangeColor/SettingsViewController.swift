//
//  SettingsViewController.swift
//  ChangeColor
//
//  Created by Алексей on 06.06.2021.
//

import UIKit

protocol settingsDelegate {
    func update(color: UIColor)
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet var colorLabels: [UILabel]!
    
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var colorTextFields: [UITextField]!
    
    
    var color: UIColor?
    var delegate: settingsDelegate?
    
    override func viewDidLoad() {
        guard let colors = color else { return }
        colorView.backgroundColor = colors
        changeColorLabels(color: colors)
        changeColorSliders(color: colors)
        changeColorTextFields(color: colors)
        
    }
    @IBAction func changeSlider(_ sender: UISlider) {
        var array:[Float] = []
        for slider in colorSliders {
            array.append(slider.value)
        }
        color = UIColor(red: CGFloat(array[0]),
                        green: CGFloat(array[1]),
                        blue: CGFloat(array[2]),
                        alpha: 1.0
        )
        guard let colors = color else {return }
        changeColorLabels(color: colors)
        changeColorTextFields(color: colors)
        colorView.backgroundColor = color
    }
    
    private func changeColorLabels(color: UIColor) {
        for label in colorLabels {
            switch label.tag {
            case 0:
                label.text = String(format: "%.2f", color.rgba.red)
            case 1:
                label.text = String(format: "%.2f", color.rgba.green)
            default:
                label.text = String(format: "%.2f", color.rgba.blue)
            }
        }

    }
    
    private func changeColorSliders(color: UIColor) {
        for slider in colorSliders {
            switch slider.tag {
            case 0:
                slider.value = Float(color.rgba.red)
            case 1:
                slider.value = Float(color.rgba.green)
            default:
                slider.value = Float(color.rgba.blue)
            }
        }

    }
    
    private func changeColorTextFields(color: UIColor) {
        for textField in colorTextFields {
            switch textField.tag {
            case 0:
                textField.placeholder = String(format: "%.2f", color.rgba.red)
            case 1:
                textField.placeholder = String(format: "%.2f", color.rgba.green)
            default:
                textField.placeholder = String(format: "%.2f", color.rgba.blue)
            }
        }

    }
    
//    @IBAction func changeRedValue(_ sender: UISlider) {
//        changeColor(slider: sender,
//                    label: redLabel,
//                    tintColor: UIColor.red,
//                    sliderColor: redSlider
//        )
//    }
//
//    @IBAction func changeGreenValue(_ sender: UISlider) {
//        changeColor(slider: sender,
//                    label: greenLabel,
//                    tintColor: UIColor.green,
//                    sliderColor: greenSlider
//        )
//    }
//
//    @IBAction func changeBlueColor(_ sender: UISlider) {
//        changeColor(slider: sender,
//                    label: blueLabel,
//                    tintColor: UIColor.blue,
//                    sliderColor: blueSlider
//        )
//    }
    @IBAction func saveSettings(_ sender: UIButton) {
        guard let colors = color else { return }
        delegate?.update(color: colors)
        dismiss(animated: true, completion: nil)
    }
    
    func changeColor(slider: UISlider, label: UILabel, tintColor: UIColor, sliderColor: UISlider) {
        slider.minimumTrackTintColor = tintColor
        sliderColor.value = slider.value
        label.text = String(format: "%.2f", slider.value)
        colorView.backgroundColor = color
    }
    
//    func getRGB() -> String {
//        return """
//            RGB(\(Int(redSlider.value * 255)), \(Int(greenSlider.value * 255)), \(Int(blueSlider.value * 255)))
//        """
//    }
//    
//    func getHex() -> String {
//        return """
//            HEX(\(String(format:"%02X", Int(redSlider.value * 255)) + String(format:"%02X", Int(greenSlider.value * 255)) + String(format:"%02X", Int(blueSlider.value * 255))))
//        """
//    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
