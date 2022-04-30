//
//  GameViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var wordContainer: WordContainerView!
    @IBOutlet weak var keyboardContainer: KeyboardView!
    @IBOutlet weak var checkWordButton: CheckWordButtonView!
    
    private let gameManager = GameManager()
    private let keyboardManager = KeyboardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCells()
        
        checkWordButton.delegate = self
        
        keyboardContainer.delegate = self
        keyboardContainer.updateKeyboardButtons(keyboardManager.getKeyboardLetters())
    }
    
    private func addCells() {
        for _ in 0..<gameManager.getAttemptsNumber() {
            let lettersContainer = LetterBoxContainerView()
            
            wordContainer.addArrangedSubview(lettersContainer)
            for _ in 0..<gameManager.getLettersCount() {
                let letterBoxView = LetterBoxView()
                
                letterBoxView.translatesAutoresizingMaskIntoConstraints = false
                letterBoxView.widthAnchor.constraint(equalTo: letterBoxView.heightAnchor).isActive = true
                
                lettersContainer.addArrangedSubview(letterBoxView)
            }
        }
    }
    
    private func getEnteredWord() -> Word {
        var enteredWord = Word()
        var rowChecked = false
        
        for row in wordContainer.subviews {
            for cell in row.subviews {
                guard let boxView = cell as? LetterBoxView, let letterBox = boxView.letterBox else {
                    break
                }
                if boxView.getLetterBoxStatus() == nil {
                    rowChecked = true
                    
                    enteredWord.append(letterBox)
                }
            }
            if rowChecked {
                break
            }
        }
        
        return enteredWord
    }
}

extension GameViewController: KeyboardButtonDelegate {
    func characterButtonTap(_ letterBox: LetterBox) {
        var lastRowLetterBoxIsEmpty = false
        
        for row in wordContainer.subviews {
            if let letterContainer = row.subviews as? [LetterBoxView] {
                for (index, cell) in letterContainer.enumerated() {
                    if cell.letterBox == nil {
                        if lastRowLetterBoxIsEmpty {
                            return
                        }
                        cell.updateLetterBox(letterBox: letterBox)
                        checkWordButton.updateStatus(enteredWord: getEnteredWord(), in: gameManager)
                        return
                    }
                    if cell.getLetterBoxStatus() == nil, index == letterContainer.count - 1 {
                        lastRowLetterBoxIsEmpty = true
                    }
                }
            }
        }
    }
    
    func deleteButtonTap() {
        for row in wordContainer.subviews {
            if let letterContainer = row.subviews as? [LetterBoxView] {
                for (index, cell) in letterContainer.enumerated() {
                    let nextIndex = index + 1
                    if  nextIndex == letterContainer.count || letterContainer[nextIndex].letterBox == nil, cell.getLetterBoxStatus() == nil {
                        cell.updateLetterBox(letterBox: nil)
                        checkWordButton.updateStatus(enteredWord: getEnteredWord(), in: gameManager)
                        return
                    }
                }
            }
        }
    }
    
    func checkWordButtonTap() {
        // test mode - not prepared !!!
        for row in wordContainer.subviews {
            if let letterContainer = row.subviews as? [LetterBoxView] {
                for (index, cell) in letterContainer.enumerated() {
                    if gameManager.getCurrentWord().contains(cell.getLetterBoxLetter()) {
                        cell.letterBox?.status = .wrongLocation
                        print(gameManager.getCurrentWord())
                    } else {
                        cell.letterBox?.status = .wrong
                    }
                }
            }
        }
        
        
        checkWordButton.updateStatus(enteredWord: getEnteredWord(), in: gameManager)
        //FILL STATUSES
    }
}

