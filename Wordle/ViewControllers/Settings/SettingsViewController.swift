//
//  SettingsViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 13.05.22.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var hardModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateSettings()
    }
    @IBAction func handleHardModeSwitch(_ sender: UISwitch) {
        UserDefaultsService.shared.encodeObject(sender.isOn, for: .hardMode)
    }
    
    private func updateSettings() {
        hardModeSwitch.isOn = UserDefaultsService.shared.decodeObject(type: Bool.self, for: .hardMode) ?? false
    }
}
