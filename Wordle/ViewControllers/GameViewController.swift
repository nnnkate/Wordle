//
//  GameViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var wordsContainer: UIStackView!
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
            
            wordsContainer.addArrangedSubview(lettersContainer)
            for _ in 0..<gameManager.getLettersCount() {
                let letterBoxView = LetterBoxView()
                
                letterBoxView.translatesAutoresizingMaskIntoConstraints = false
                letterBoxView.widthAnchor.constraint(equalTo: letterBoxView.heightAnchor).isActive = true
                
                lettersContainer.addArrangedSubview(letterBoxView)
            }
        }
    }
    
}

extension GameViewController: KeyboardButtonDelegate {
    func characterButtonTap(_ letterBox: LetterBox) {
        for row in wordsContainer.subviews {
            for cell in row.subviews {
               if let boxView = cell as? LetterBoxView, boxView.letterBox == nil {
                    boxView.updateLetterBox(letterBox: letterBox)
                    return
                }
            }
        }
   }
    
    func deleteButtonTap() {
        rowLoop: for row in wordsContainer.subviews {
            if let letterContainer = row.subviews as? [LetterBoxView] {
                for (index, value) in letterContainer.enumerated() {
                    let previousIndex = index == 0 ? 0 : index - 1
                    if value.letterBox == nil, previousIndex < letterContainer.count {
                        if letterContainer[previousIndex].getLetterBoxStatus() != nil {
                            continue rowLoop
                        }
                        letterContainer[previousIndex].updateLetterBox(letterBox: nil)
                        return
                    }
                }
            }
        }
    }
    
    func checkWordButtonTap() {
        var rowChecked = false
        var enteredWord = Word()
        
        for row in wordsContainer.subviews {
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
        
        if enteredWord.count < gameManager.getLettersCount() {
            print("not word, count error")
            return
        }
        
        print(enteredWord.isAllowed(in: gameManager))
    }
}
