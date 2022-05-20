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
        UserDefaultsService.shared.encodeObject(sender.isOn, for: .hardMode)
    }
    
    @IBAction func handleUserNameEditingChanged(_ sender: UITextField) {
        UserDefaultsService.shared.encodeObject(sender.text, for: .userName)
    }
    
    private func updateSettings() {
        hardModeSwitch.isOn = UserDefaultsService.shared.decodeObject(type: Bool.self, for: .hardMode) ?? false
        
        userNameTextField.text = UserDefaultsService.shared.decodeObject(type: String.self, for: .userName) ?? ""
    }
}
