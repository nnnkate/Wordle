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
    
    private let gameManager = GameManager()
    private let keyboardManager = KeyboardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordsContainer.updateGameField(gameManager.gameField)
        
        checkWordButton.delegate = self
        
        keyboardContainer.delegate = self
        keyboardContainer.updateKeyboardButtons(keyboardManager.keyboardLetters)
    }
}

extension GameViewController: KeyboardButtonDelegate {
    func handleButtonTap(type keyboardButtonType: KeyboardButtonType) {
        gameManager.handleButtonTap(type: keyboardButtonType)
        
        wordsContainer.updateGameField(gameManager.gameField)
        
        checkWordButton.updateStatus(gameManager: gameManager)
    }
}

