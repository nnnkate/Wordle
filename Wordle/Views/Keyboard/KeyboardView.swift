//
//  KeyboardView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

final class KeyboardView: UIStackView {
    var keyboardLetters: [[LetterBox]]
    
    weak var delegate: GameViewController?
    
    private var buttonsContainer = [[CharacterKeyboardButtonView]]()
    
    init(keyboardLetters: [[LetterBox]]) {
        self.keyboardLetters = keyboardLetters
        
        super.init(frame: .zero)
        
        self.setUpView()
    }
    
    required init(coder: NSCoder) {
        self.keyboardLetters = []
        
        super.init(coder: coder)
        
        self.setUpView()
    }
    
    private func setUpView() {
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fillEqually
        self.spacing = 5
        
        createKeyboard()
    }
    
    private func createKeyboard() {
        for (index, row) in keyboardLetters.enumerated() {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 5
            
            self.addArrangedSubview(stackView)
            
            buttonsContainer.append([CharacterKeyboardButtonView]())
            
            for box in row {
                let characterKeyboardBoxView = CharacterKeyboardButtonView(keyboardButton: box)
                characterKeyboardBoxView.delegate = delegate
                
                stackView.addArrangedSubview(characterKeyboardBoxView)
                
                buttonsContainer[index].append(characterKeyboardBoxView)
            }
            if index == keyboardLetters.count - 1 {
                let deleteKeyboardButtonView = DeleteKeyboardButtonView()
                deleteKeyboardButtonView.delegate = delegate
                stackView.addArrangedSubview(deleteKeyboardButtonView)
            }
        }
    }
    
    func fillKeyboardButtons(_ keyboardLetters: [[LetterBox]]) {
        self.keyboardLetters = keyboardLetters
        
        createKeyboard()
    }
    
    func updateKeyboardButtons(_ gameField: [[LetterBox?]]) {
        
        let flatGameField = gameField.flatMap { $0 }
        
        let lettersStastuses = flatGameField.reduce(into: [String: Evaluation]()) { partialResult, element in
            guard let element = element else {
                return
            }
            
            partialResult[element.letter,  default: Evaluation.wrong] = ( partialResult[element.letter] == Evaluation.correct ? Evaluation.correct : element.status ?? .wrong)
        }
        
      for (rowIndex, row) in keyboardLetters.enumerated() {
            for (letterIndex, var letterBox) in row.enumerated() {
                letterBox.setStatus(lettersStastuses[letterBox.letter] ?? .wrong)
                buttonsContainer[rowIndex][letterIndex].updateBackground(status: lettersStastuses[letterBox.letter])
            }
        }
    }
}
