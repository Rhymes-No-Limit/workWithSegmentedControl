//
//  ViewController.swift
//  workWithSegmentedControl
//
//  Created by Андрей Терентьев on 24.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var uiElements = ["UISegmentedControl",
                      "UILabel",
                      "UISlider",
                      "UITextField",
                      "UIButton",
                      "UIDatePicker"]
    
    var selectedElement: String?

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
        
        choiceUiElement()
        createToolbar()
    }
    
    func hideAllElement() {
        segmentedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        doneButton.isHidden = true
        datePicker.isHidden = true
        
    }
    
    func choiceUiElement() {
        
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        textField.inputView = elementPicker
        
        // Customization
        elementPicker.backgroundColor = .brown
    }
    
    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar
        
        // Customization
        toolbar.tintColor = .white
        toolbar.barTintColor = .brown
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideAllElement()
            segmentedControl.isHidden = false
        case 1:
            hideAllElement()
            label.isHidden = false
        case 2:
            hideAllElement()
            slider.isHidden = false
        case 3:
            hideAllElement()
        case 4:
            hideAllElement()
            doneButton.isHidden = false
        case 5:
            hideAllElement()
            datePicker.isHidden = false
        default:
            hideAllElement()
        }
    
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        pickerViewLabel.text = uiElements[row]
        
        return pickerViewLabel
    }
    
}
