//
//  ViewController.swift
//  ChangeColor
//
//  Created by Алексей on 21.05.2021.
//

import UIKit

class ViewController: UIViewController, settingsDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        let bgColor:UIColor = view.backgroundColor!
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a: CGFloat = 0
        if bgColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
            settingsVC.color = UIColor(red: r, green: g, blue: b, alpha: a)
        }
    }
    
    @IBAction func settingsButton(_ sender: UIButton) {
    }
    
    func update(color: UIColor) {
        view.backgroundColor = color
    }
    
}


