//
//  MainMenuViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 13.05.22.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleGameButtonTap(_ sender: Any) {
        if let gameViewContoller = UIStoryboard(name: "GameStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "gameVC") as? GameViewController {
            navigationController?.pushViewController(gameViewContoller, animated: true)
        }
    }
    
    @IBAction func handleLeadersBoarViewContollerButtonTap(_ sender: Any) {
        if let leadersBoardViewContoller = UIStoryboard(name: "LeadersBoardStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "leadersBoardVC") as? LeadersBoardViewController {
            navigationController?.pushViewController(leadersBoardViewContoller, animated: true)
        }
    }
    
    @IBAction func handleSettingsButtonTap(_ sender: Any) {
        if let settingsViewContoller = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
            .instantiateViewController(withIdentifier: "settingsVC") as? SettingsViewController {
            navigationController?.pushViewController(settingsViewContoller, animated: true)
        }
    }
}
