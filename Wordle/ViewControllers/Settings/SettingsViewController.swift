//
//  SettingsViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 13.05.22.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var hardModeSwitch: UISwitch!
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateSettings()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func handleHardModeSwitch(_ sender: UISwitch) {
        UserDefaultsService.shared.setBoolValue(for: .hardMode, value: sender.isOn)
    }
    
    @IBAction func handleUserNameEditingChanged(_ sender: UITextField) {
        guard let userName = sender.text else { return }
        
        UserDefaultsService.shared.setStringValue(for: .userName, value: userName)
    }
    
    private func updateSettings() {
        hardModeSwitch.isOn = UserDefaultsService.shared.getBoolValue(for: .hardMode)
        
        userNameTextField.text = UserDefaultsService.shared.getStringValue(for: .userName)

    }
}
