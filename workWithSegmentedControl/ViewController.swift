//
//  ViewController.swift
//  workWithSegmentedControl
//
//  Created by Андрей Терентьев on 24.04.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var label: UILabel!
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var doneButton: UISwitch!
    @IBOutlet var switchLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = 1

        label.text = String(slider.value)
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
    }


    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        
        label.isHidden = false
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = .red
        case 1:
            label.text = "The second segment is selected"
            label.textColor = .blue
        case 2:
            label.text = "The third segment is selected"
            label.textColor = .yellow
        default:
            label.text = "Something wrong"
        }
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    @IBAction func donePressed(_ sender: UIButton) {
        
        guard let text = textField.text, !text.isEmpty else { return }
        
        if !text.allSatisfy({ $0.isLetter }) {
            
            let alert = UIAlertController(title: "Wrong format", message: "Please enter your name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)

        } else {
            
            label.text = text
            textField.text = nil
        }
        
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        
        let dateFormater = DateFormatter()
        
        dateFormater.dateStyle = .medium
        dateFormater.locale = Locale(identifier: "ru_Ru")
        
        let dateValue = dateFormater.string(from: sender.date)
        
        label.text = dateValue
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        segmentedControl.isHidden = !segmentedControl.isHidden
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        textField.isHidden = !textField.isHidden
        datePicker.isHidden = !datePicker.isHidden
        doneButton.isHidden = !doneButton.isHidden
        
        if sender.isOn {
            switchLabel.text = "Отобразить все элементы"
        } else {
            switchLabel.text = "Скрыть все элементы"
        }
    }
}

