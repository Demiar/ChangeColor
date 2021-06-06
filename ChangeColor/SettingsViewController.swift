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
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet var colorTextFields: [UITextField]!
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    var color: UIColor?
    var delegate: settingsDelegate?
    
    override func viewDidLoad() {
        redTF.delegate = self;
        self.addDoneButtonOnKeyboard(textField: redTF)
        greenTF.delegate = self;
        self.addDoneButtonOnKeyboard(textField: greenTF)
        blueTF.delegate = self;
        self.addDoneButtonOnKeyboard(textField: blueTF)
        guard let colors = color else { return }
        colorView.backgroundColor = colors
        changeColorLabels(color: colors)
        changeColorSliders(color: colors)
        changeColorTextFields(color: colors)
        
    }
    @IBAction func changeSlider(_ sender: UISlider) {
        color = UIColor(red: CGFloat(redSlider.value),
                        green: CGFloat(greenSlider.value),
                        blue: CGFloat(blueSlider.value),
                        alpha: 1.0
        )
        guard let colors = color else {return }
        changeColorLabels(color: colors)
        changeColorTextFields(color: colors)
        colorView.backgroundColor = color
    }
    
    @IBAction func changeTF(_ sender: UITextField) {
        let red = Float(redTF.text!) ?? redSlider.value
        let green = Float(greenTF.text!) ?? greenSlider.value
        let blue = Float(blueTF.text!) ?? blueSlider.value
        color = UIColor(red: CGFloat(red),
                        green: CGFloat(green),
                        blue: CGFloat(blue),
                        alpha: 1.0
        )
        guard let colors = color else {return }
        changeColorLabels(color: colors)
        changeColorTextFields(color: colors)
        colorView.backgroundColor = color
    }


    @IBAction func saveSettings(_ sender: UIButton) {
        guard let colors = color else { return }
        delegate?.update(color: colors)
        dismiss(animated: true, completion: nil)
    }
    
//    func changeColor(slider: UISlider, label: UILabel, tintColor: UIColor, sliderColor: UISlider) {
//        slider.minimumTrackTintColor = tintColor
//        sliderColor.value = slider.value
//        label.text = String(format: "%.2f", slider.value)
//        colorView.backgroundColor = color
//    }
    
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
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func addDoneButtonOnKeyboard(textField: UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(SettingsViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.view.endEditing(true);
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }

        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }

        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2 && Float(newText) ?? 0.00 <= 1.00
    }
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
