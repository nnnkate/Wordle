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
        keyboardContainer.updateKeyboardButtons(keyboardManager.keyboardLetters)
    }
    
    private func addCells() {
        for _ in 0..<gameManager.attemptsCount {
            let lettersContainer = LetterBoxContainerView()
            
            wordContainer.addArrangedSubview(lettersContainer)
            for _ in 0..<gameManager.lettersCount {
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
        let currentWordLettersArray = Array(gameManager.currentWord)
        print(currentWordLettersArray)
        
        for rowValue in wordContainer.subviews {
            if let letterContainer = rowValue.subviews as? [LetterBoxView] {
                for (cellIndex, cellValue) in letterContainer.enumerated() {
                    if cellValue.getLetterBoxStatus() != nil {
                        break
                    }
                        
                    let cellLetter = cellValue.getLetterBoxLetter()
                    if gameManager.currentWord.contains(cellLetter) {
                        if String(currentWordLettersArray[cellIndex]) == cellLetter {
                            cellValue.setLetterBoxStatus(.correct)
                        } else {
                            cellValue.setLetterBoxStatus(.wrongLocation)
                        }
                    } else {
                        cellValue.setLetterBoxStatus(.wrong)
                    }
                }
            }
        }
        
        checkWordButton.updateStatus(enteredWord: getEnteredWord(), in: gameManager)
        
        setCheckResult()
    }
        
    func updateWordContainer() {
        for (rowIndex, rowValue) in wordContainer.subviews.enumerated() {
            if let letterContainer = rowValue.subviews as? [LetterBoxView] {
                for (cellIndex, cellValue) in letterContainer.enumerated() {
                    cellValue.updateLetterBox(letterBox: gameManager.gameField[rowIndex][cellIndex])
                }
            }
        }
    }
        
    func setCheckResult() {
        for (rowIndex, rowValue) in wordContainer.subviews.enumerated() {
            if let letterContainer = rowValue.subviews as? [LetterBoxView] {
                for (cellIndex, cellValue) in letterContainer.enumerated() {
                    gameManager.setCellValue(rowIndex: rowIndex, cellIndex: cellIndex, value: cellValue.letterBox)
                }
            }
        }
    }
}

