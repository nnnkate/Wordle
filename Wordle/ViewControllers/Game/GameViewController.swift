//
//  GameViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var wordsContainer: WordsContainerView!
    @IBOutlet weak var keyboardContainer: KeyboardView!
    @IBOutlet weak var checkWordButton: CheckWordButtonView!
    @IBOutlet weak var timerLabel: UILabel!
    
    private var gameManager = GameManager()
    private let keyboardManager = KeyboardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordsContainer.updateGameField(gameManager.gameField)
        
        checkWordButton.delegate = self
        keyboardContainer.delegate = self
        gameManager.delegate = self
        
        keyboardContainer.fillKeyboardButtons(keyboardManager.keyboardLetters)
    }
}

extension GameViewController: KeyboardButtonDelegate {
    func handleButtonTap(type keyboardButtonType: KeyboardButtonType) {
        gameManager.handleButtonTap(type: keyboardButtonType)
        
        wordsContainer.updateGameField(gameManager.gameField)
        
        if keyboardButtonType == .enter {
            keyboardContainer.updateKeyboardButtons(gameManager.gameField)
        }
        
        checkWordButton.updateStatus(gameManager: gameManager)
    }
}

extension GameViewController: GameDelegate {
    func handleGameEnd(_ gameStatus: GameStatus) {
        showAlert(title: gameStatus == .win ? "You win :)" : "You lost :(",
                  message: "Do you want to start a new game?")
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                 message: message,
                                                 preferredStyle: .alert)
        
        let restartGameAction = UIAlertAction(title: "Restart", style: .default) {_ in
            self.restartGame()
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
        
        let backToMainMenuAction = UIAlertAction(title: "Back to main menu", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(restartGameAction)
        alertController.addAction(dismissAction)
        alertController.addAction(backToMainMenuAction)
        
        present(alertController, animated: true)
    }
    
    private func restartGame() {
        gameManager.restartGame()
        
        wordsContainer.updateGameField(gameManager.gameField)
        keyboardContainer.updateKeyboardButtons(gameManager.gameField)
    }
    
    func updateTimer(_ timerCounter: Int) {
        var timerCounter = timerCounter
        let hours = max(timerCounter / 360, 0)
        timerCounter -= (hours * 360)
        let minutes = max(timerCounter / 60, 0)
        timerCounter -= minutes * 60
        
        timerLabel.text = String("\(hours):\(String(format: "%02d", minutes)):\(String(format: "%02d", timerCounter))")
    }
}


